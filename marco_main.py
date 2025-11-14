"""
ORBIT MACRO - PRODUCT PERFORMANCE ANALYSIS
Answers practical business questions about products
"""

from dotenv import load_dotenv
load_dotenv()

from db import Database
from macro_ahp_engine import ORBITMacroAgent
from macro_visualizer import ORBITMacroVisualizer
from models import VendorProfile

def demo_macro_system():
    """
    Product Performance Analysis
    Answers: What's working? What's not? What should we do?
    """
    
    print("="*70)
    print("🏢 ORBIT MACRO - Product Performance & Strategy")
    print("="*70)
    
    # Init
    db = Database()
    agent = ORBITMacroAgent()
    viz = ORBITMacroVisualizer()
    
    # Demo vendors - multiple categories
    demo_scenarios = [
        {
            "vendor_id": "vnd_techbuy",
            "category": "cat_laptops",
            "vendor_name": "TechBuy Electronics"
        },
        {
            "vendor_id": "vnd_kickstyle",
            "category": "cat_sneakers",
            "vendor_name": "KickStyle Sneakers"
        },
        {
            "vendor_id": "vnd_brewmaster",
            "category": "cat_coffee",
            "vendor_name": "BrewMaster Coffee Co"
        }
    ]
    
    for scenario in demo_scenarios:
        vendor_id = scenario["vendor_id"]
        category = scenario["category"]
        vendor_name = scenario["vendor_name"]
        
        print(f"\n\n{'='*70}")
        print(f"🏢 ANALYZING: {vendor_name}")
        print(f"{'='*70}")
        
        # QUESTION 1: Which products are doing well?
        print(f"\n{'='*70}")
        print("❓ QUESTION 1: Which products are performing best?")
        print(f"{'='*70}")
        
        # Get product insights
        product_insights = db.supabase.table('product_aggregate_insights').select(
            '*, products(*)'
        ).eq('vendor_id', vendor_id).eq('category_id', category).execute()
        
        if product_insights.data:
            products_sorted = sorted(product_insights.data, 
                                    key=lambda x: x['conversion_rate'], reverse=True)
            
            print(f"\n✅ TOP 5 PERFORMING PRODUCTS:")
            for i, p in enumerate(products_sorted[:5], 1):
                product_name = p['products']['product_name'] if p.get('products') else p['product_id']
                print(f"\n{i}. {product_name}")
                print(f"   📊 Views: {p['total_views']} | Purchases: {p['total_purchases']}")
                print(f"   💰 Conversion: {p['conversion_rate']*100:.1f}%")
                print(f"   👥 Primary Buyer: {p['primary_segment'].replace('_', ' ').title()}")
                
                # Show what this segment values
                criteria_weights = p['avg_criteria_weights']
                top_criteria = sorted(criteria_weights.items(), key=lambda x: x[1], reverse=True)[:3]
                print(f"   🎯 This segment values: {', '.join([c[0] for c in top_criteria])}")
        
        # QUESTION 2: What's not selling?
        print(f"\n\n{'='*70}")
        print("❓ QUESTION 2: Which products are underperforming?")
        print(f"{'='*70}")
        
        if product_insights.data:
            print(f"\n❌ BOTTOM 5 PRODUCTS (Need Attention):")
            for i, p in enumerate(products_sorted[-5:], 1):
                product_name = p['products']['product_name'] if p.get('products') else p['product_id']
                print(f"\n{i}. {product_name}")
                print(f"   📊 Views: {p['total_views']} | Purchases: {p['total_purchases']}")
                print(f"   💰 Conversion: {p['conversion_rate']*100:.1f}%")
                
                # Diagnose the problem
                if p['total_views'] > 50 and p['conversion_rate'] < 0.10:
                    print(f"   ⚠️  PROBLEM: High traffic, low conversion - likely pricing or positioning issue")
                elif p['total_views'] < 20:
                    print(f"   ⚠️  PROBLEM: Low visibility - needs marketing/SEO")
                else:
                    print(f"   ⚠️  PROBLEM: Product doesn't match customer needs")
        

        # QUESTION 3: Product gaps analysis
        print(f"\n\n{'='*70}")
        print("❓ QUESTION 3: What product opportunities exist?")
        print(f"{'='*70}")
        
        # Get vendor strategic data
        result = db.supabase.table('vendor_strategic_insights').select(
            '*, vendors(*)'
        ).eq('vendor_id', vendor_id).eq('category_id', category).execute()
        
        if not result.data:
            print(f"   ⚠️  No strategic data found")
            continue
        
        insight = result.data[0]
        
        vendor_profile = VendorProfile(
            vendor_id=vendor_id,
            vendor_name=vendor_name,
            category_id=category,
            market_share=float(insight['market_share']),
            avg_conversion_rate=float(insight['avg_conversion_rate']),
            total_products=insight['total_products'],
            total_sales=insight['total_sales'],
            avg_customer_criteria=insight['avg_customer_criteria'],
            customer_segments=insight['customer_segments']
        )
        
        print(f"\n📊 Your Customer Base:")
        for seg, pct in vendor_profile.customer_segments.items():
            print(f"   • {seg.replace('_', ' ').title()}: {pct*100:.0f}%")
        
        print(f"\n🎯 What Customers Value Most:")
        sorted_criteria = sorted(vendor_profile.avg_customer_criteria.items(), 
                                key=lambda x: x[1], reverse=True)
        for i, (criteria, weight) in enumerate(sorted_criteria[:3], 1):
            print(f"   {i}. {criteria.replace('_', ' ').title()}: {weight:.2f}")
        
        # Identify gaps
        print(f"\n💡 PRODUCT GAPS IDENTIFIED:")
        
        # Check if we're serving all segments
        for segment, pct in vendor_profile.customer_segments.items():
            if pct > 0.2:  # Significant segment
                segment_products = [p for p in products_sorted 
                                  if p['primary_segment'] == segment]
                if len(segment_products) < 3:
                    print(f"   ⚠️  Only {len(segment_products)} products targeting {segment.replace('_', ' ').title()} ({pct*100:.0f}% of customers)")
        
        # Check criteria alignment
        top_criteria = sorted_criteria[0][0]
        print(f"\n   💡 Customers value '{top_criteria}' most - ensure products highlight this")
        
        # QUESTION 4: Strategic recommendations
        print(f"\n\n{'='*70}")
        print("❓ QUESTION 4: What should we do to improve?")
        print(f"{'='*70}")
        
        print(f"\n🤖 Running AI strategic analysis...")
        
        # Run AHP
        ranked_alternatives, criteria, ahp_matrices = agent.run_strategic_analysis(vendor_profile)
        bocr = agent.generate_bocr(ranked_alternatives[0], vendor_profile)
        
        # Custom prompt focused on products
        product_prompt = f"""You are analyzing {vendor_profile.vendor_name}'s product performance.

## PRODUCT PERFORMANCE DATA
Total Products: {vendor_profile.total_products}
Average Conversion: {vendor_profile.avg_conversion_rate*100:.1f}%

Top Performers: {', '.join([p['products']['product_name'] for p in products_sorted[:3] if p.get('products')])}
Underperformers: {', '.join([p['products']['product_name'] for p in products_sorted[-3:] if p.get('products')])}

## CUSTOMER DATA
Segments: {', '.join([f'{k}: {v*100:.0f}%' for k,v in vendor_profile.customer_segments.items()])}
Top Priority: {sorted_criteria[0][0]} ({sorted_criteria[0][1]:.2f})

## YOUR TASK
Answer these questions clearly:

1. **What's working well?** (2-3 sentences about top products)

2. **Why are some products failing?** (2-3 sentences with specific reasons)

3. **Top 3 immediate actions to improve sales:**
   - Action 1: [Specific product-level action]
   - Action 2: [Specific pricing/positioning action]
   - Action 3: [Specific marketing action]

4. **Product portfolio strategy:** Should we expand budget/premium/midrange? Why?

Be specific and actionable. Reference the actual data."""

        response = agent.model.generate_content(product_prompt)
        
        print(f"\n{'='*70}")
        print("💡 AI STRATEGIC RECOMMENDATIONS")
        print(f"{'='*70}")
        print(response.text)
        
        # Show AHP strategy recommendations
        # print(f"\n{'='*70}")
        # print("📊 AHP STRATEGIC ANALYSIS")
        # print(f"{'='*70}")
        
        # print(f"\n🎯 Top 3 Strategic Moves (Math-Backed):")
        # for alt in ranked_alternatives[:3]:
        #     print(f"\n{alt.rank}. {alt.alternative.name.replace('_', ' ').title()} (Score: {alt.ahp_score:.3f})")
        #     print(f"   {alt.alternative.description}")
        
        # # BOCR Summary
        # print(f"\n⚖️  RISK/BENEFIT ANALYSIS for #{1}:")
        # print(f"   ✅ Benefits: {bocr.total_benefits:.2f}")
        # print(f"   🚀 Opportunities: {bocr.total_opportunities:.2f}")
        # print(f"   💰 Costs: {bocr.total_costs:.2f}")
        # print(f"   ⚠️  Risks: {bocr.total_risks:.2f}")
        # print(f"   📊 Net Score: {bocr.net_score:.2f} {'(FAVORABLE)' if bocr.net_score > 0 else '(RISKY)'}")
        
        # Visualizations
        print(f"\n📈 Generating visual reports...")
        viz.plot_final_rankings(ranked_alternatives, vendor_profile.vendor_name)
        viz.plot_bocr_analysis(bocr, vendor_profile.vendor_name)
        viz.plot_customer_segments(vendor_profile, vendor_profile.vendor_name)
        
        print(f"\n{'='*70}")
        print(f"✅ Analysis complete for {vendor_profile.vendor_name}!")
        print(f"   📊 Charts saved to: ./output/macro/{vendor_profile.vendor_name}_*.png")
        print(f"{'='*70}")
        
        input("\n⏸️  Press Enter for next vendor...")

def interactive_mode():
    """Ask custom questions about your products"""
    
    print("="*70)
    print("🏢 ORBIT MACRO - Interactive Product Advisor")
    print("="*70)
    
    db = Database()
    agent = ORBITMacroAgent()
    
    # Pick vendor
    print("\nAvailable vendors:")
    print("1. vnd_techbuy (laptops)")
    print("2. vnd_brewmaster (coffee)")
    print("3. vnd_kickstyle (sneakers)")
    
    choice = input("\nSelect vendor (1-3): ").strip()
    vendor_map = {
        "1": ("vnd_techbuy", "cat_laptops", "TechBuy Electronics"),
        "2": ("vnd_brewmaster", "cat_coffee", "BrewMaster Coffee Co"),
        "3": ("vnd_kickstyle", "cat_sneakers", "KickStyle Sneakers")
    }
    
    vendor_id, category, vendor_name = vendor_map.get(choice, ("vnd_techbuy", "cat_laptops", "TechBuy Electronics"))
    
    print(f"\n🏢 Analyzing: {vendor_name}")
    
    # Get data
    result = db.supabase.table('vendor_strategic_insights').select('*').eq(
        'vendor_id', vendor_id).eq('category_id', category).execute()
    
    if not result.data:
        print("❌ No data found")
        return
    
    insight = result.data[0]
    vendor_profile = VendorProfile(
        vendor_id=vendor_id,
        vendor_name=vendor_name,
        category_id=category,
        market_share=float(insight['market_share']),
        avg_conversion_rate=float(insight['avg_conversion_rate']),
        total_products=insight['total_products'],
        total_sales=insight['total_sales'],
        avg_customer_criteria=insight['avg_customer_criteria'],
        customer_segments=insight['customer_segments']
    )
    
    print(f"\n📊 Quick Stats:")
    print(f"   Products: {vendor_profile.total_products}")
    print(f"   Sales: {vendor_profile.total_sales}")
    print(f"   Conversion: {vendor_profile.avg_conversion_rate*100:.1f}%")
    
    while True:
        question = input("\n💬 Ask about your products (or 'quit'): ").strip()
        
        if question.lower() in ['quit', 'exit', 'q']:
            break
        
        if not question:
            continue
        
        print(f"\n🤖 Analyzing...")
        
        ranked_alternatives, _, _ = agent.run_strategic_analysis(vendor_profile)
        
        print(f"\n🎯 Recommendations:")
        for alt in ranked_alternatives[:3]:
            print(f"   {alt.rank}. {alt.alternative.name.replace('_', ' ').title()} ({alt.ahp_score:.3f})")

def quick_test():
    """Quick test"""
    print("🧪 Testing macro system...\n")
    
    db = Database()
    agent = ORBITMacroAgent()
    
    result = db.supabase.table('vendor_strategic_insights').select('*').eq(
        'vendor_id', 'vnd_techbuy').eq('category_id', 'cat_laptops').execute()
    
    if not result.data:
        print("❌ No data")
        return
    
    insight = result.data[0]
    vendor_profile = VendorProfile(
        vendor_id='vnd_techbuy',
        vendor_name='TechBuy Electronics',
        category_id='cat_laptops',
        market_share=float(insight['market_share']),
        avg_conversion_rate=float(insight['avg_conversion_rate']),
        total_products=insight['total_products'],
        total_sales=insight['total_sales'],
        avg_customer_criteria=insight['avg_customer_criteria'],
        customer_segments=insight['customer_segments']
    )
    
    ranked_alternatives, _, _ = agent.run_strategic_analysis(vendor_profile)
    
    print(f"✅ Test passed!")
    print(f"Top strategy: {ranked_alternatives[0].alternative.name}")

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1:
        if sys.argv[1] == "test":
            quick_test()
        elif sys.argv[1] == "interactive":
            interactive_mode()
        else:
            demo_macro_system()
    else:
        demo_macro_system()