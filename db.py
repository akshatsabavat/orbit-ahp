from supabase import create_client, Client
from typing import List, Optional
from models import User, Product, Purchase, Vendor, VendorInventory, EnrichedPurchase
import os

class Database:
    def __init__(self):
        self.supabase: Client = create_client(
            os.getenv("SUPABASE_URL"),
            os.getenv("SUPABASE_KEY")
        )
    
    # get user by id
    def get_user(self, user_id: str) -> Optional[User]:
        result = self.supabase.table('users').select('*').eq('user_id', user_id).execute()
        if result.data:
            return User(**result.data[0])
        return None
    
    # get all user purchases with full product/vendor details
    def get_user_purchase_history(self, user_id: str, category_id: Optional[str] = None) -> List[EnrichedPurchase]:
        # join purchases -> inventory -> products -> vendors
        query = self.supabase.table('purchase_history').select(
            '*, vendor_inventory(*, products(*), vendors(*))'
        ).eq('user_id', user_id)
        
        result = query.execute()
        
        enriched = []
        for row in result.data:
            # filter by category if specified
            if category_id and row['vendor_inventory']['products']['category_id'] != category_id:
                continue
                
            enriched.append(EnrichedPurchase(
                purchase=Purchase(**{k: v for k, v in row.items() if k != 'vendor_inventory'}),
                product=Product(**row['vendor_inventory']['products']),
                vendor=Vendor(**row['vendor_inventory']['vendors']),
                inventory=VendorInventory(**{k: v for k, v in row['vendor_inventory'].items() 
                                            if k not in ['products', 'vendors']})
            ))
        
        return enriched
    
    # search products by category and optional filters
    def search_products(self, category_id: str, query: Optional[str] = None, 
                       brand: Optional[str] = None, max_price: Optional[float] = None) -> List[Product]:
        q = self.supabase.table('products').select('*').eq('category_id', category_id)
        
        if brand:
            q = q.eq('brand', brand)
        if max_price:
            q = q.lte('base_price', max_price)
        if query:
            # simple text search on product name
            q = q.ilike('product_name', f'%{query}%')
        
        result = q.execute()
        return [Product(**p) for p in result.data]
    
    # get all inventory for a product (different vendors selling it)
    def get_product_inventory(self, product_id: str) -> List[tuple[VendorInventory, Vendor]]:
        result = self.supabase.table('vendor_inventory').select(
            '*, vendors(*)'
        ).eq('product_id', product_id).eq('is_available', True).execute()
        
        inventory_list = []
        for row in result.data:
            inventory = VendorInventory(**{k: v for k, v in row.items() if k != 'vendors'})
            vendor = Vendor(**row['vendors'])
            inventory_list.append((inventory, vendor))
        
        return inventory_list
    
    # get multiple products with their inventory options
    def get_products_with_inventory(self, product_ids: List[str]) -> List[tuple[Product, List[tuple[VendorInventory, Vendor]]]]:
        products = self.supabase.table('products').select('*').in_('product_id', product_ids).execute()
        
        results = []
        for p_data in products.data:
            product = Product(**p_data)
            inventory = self.get_product_inventory(product.product_id)
            results.append((product, inventory))
        
        return results