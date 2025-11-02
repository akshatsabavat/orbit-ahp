from dotenv import load_dotenv
load_dotenv()

from db import Database
from ahp_engine import ORBITAgent
from visualizer import ORBITVisualizer
import json

def demo_orbit_system():
    """
    Query-driven ORBIT demo
    User asks natural language questions → Agent returns ranked results
    """
    
    print("="*70)
    print("🛸 ORBIT - Query-Driven AI Product Ranking System")
    print("   Powered by AHP (Analytic Hierarchy Process)")
    print("="*70)
    
    # init
    db = Database()
    agent = ORBITAgent()
    viz = ORBITVisualizer()
    
    # demo queries - different users with different needs
    demo_scenarios = [
        {
            "user_id": "usr_001",
            "username": "budget_bob",
            "query": "I need a cheap laptop for basic work and browsing under $800",
            "category": "cat_laptops",
            "description": "Price-sensitive buyer, always chooses budget tier"
        },
        {
            "user_id": "usr_002",
            "username": "performance_paula",
            "query": "Best laptop for gaming and video editing, need RTX graphics",
            "category": "cat_laptops",
            "description": "Performance-focused, willing to pay premium"
        },
        {
            "user_id": "usr_003",
            "username": "apple_andy",
            "query": "Looking for a MacBook for college, good battery life",
            "category": "cat_laptops",
            "description": "100% Apple ecosystem loyalty"
        },
        {
            "user_id": "usr_008",
            "username": "runner_rachel",
            "query": "Need running shoes with great cushioning for marathons",
            "category": "cat_sneakers",
            "description": "Running shoe specialist, buys frequently"
        },
        {
            "user_id": "usr_007",
            "username": "coffee_connoisseur_carlos",
            "query": "Looking for premium single origin coffee, prefer light roast",
            "category": "cat_coffee",
            "description": "Coffee enthusiast, only buys premium beans"
        },
        {
            "user_id": "usr_001",
            "username": "budget_bob",  
            "query": "cheap running shoes under $100 for gym",
            "category": "cat_sneakers",
            "description": "Same user (Bob) but different category - shows cross-category price sensitivity"
        },
        {
            "user_id": "usr_002",
            "username": "performance_paula",
            "query": "flagship smartphone with best camera for content creation",
            "category": "cat_phones",
            "description": "Same user (Paula) - consistently prioritizes specs across categories"
        }
    ]
    
    for scenario in demo_scenarios:
        user_id = scenario["user_id"]
        username = scenario["username"]
        query = scenario["query"]
        category_id = scenario["category"]
        
        print(f"\n\n{'='*70}")
        print(f"👤 USER: {username}")
        print(f"💬 QUERY: '{query}'")
        print(f"{'='*70}")
        
        # fetch user's purchase history
        print("\n📜 Loading purchase history...")
        purchase_history = db.get_user_purchase_history(user_id)
        
        if purchase_history:
            print(f"   Found {len(purchase_history)} past purchases:")
            for p in purchase_history[:3]:
                print(f"   - {p.product.product_name} (${p.purchase.total_paid:.2f})")
            if len(purchase_history) > 3:
                print(f"   ... and {len(purchase_history) - 3} more")
        else:
            print("   No purchase history (new user)")
        
        # fetch candidate products
        print(f"\n🔍 Searching for products...")
        products = db.search_products(category_id)
        print(f"   Retrieved {len(products)} products from database")
        
        # run the agent with query
        ranked_results, user_profile, ahp_matrices = agent.run_query(
            user_id=user_id,
            query=query,
            purchase_history=purchase_history,
            candidate_products=products
        )
        
        # display top 5 results
        print(f"\n{'='*70}")
        print("🎯 TOP 5 RECOMMENDATIONS")
        print(f"{'='*70}")
        print(f"{'Rank':<6} {'Product':<40} {'Price':<12} {'AHP Score'}")
        print("-" * 70)
        
        for i, result in enumerate(ranked_results[:5], 1):
            print(f"{i:<6} {result.product.product_name[:39]:<40} "
                  f"${result.product.base_price:<11.2f} {result.ahp_score:.4f}")
        
        # show why #1 was chosen
        if ranked_results:
            top_pick = ranked_results[0]
            print(f"\n📊 WHY #{1}? ({top_pick.product.product_name})")
            print("-" * 70)
            print(f"{'Criteria':<20} {'Score':<10} {'Weight':<10} {'Contribution'}")
            print("-" * 70)
            
            for criteria, score in top_pick.criteria_scores.items():
                weight = next((w.weight for w in user_profile.criteria_weights 
                             if w.criteria_name == criteria), 0)
                contribution = score * weight
                print(f"{criteria:<20} {score:<10.3f} {weight:<10.3f} {contribution:.4f}")
            
            print(f"\n{'Total AHP Score:':<20} {top_pick.ahp_score:.4f}")
        
        # generate visualizations
        print(f"\n📈 Generating visualizations...")
        viz.generate_full_report(ranked_results, user_profile, username, ahp_matrices)
        
        print(f"\n{'='*70}")
        print(f"✅ Results for {username} complete!")
        print(f"   Check ./output/{username}_*.png for visualizations")
        print(f"{'='*70}")
        
        # pause before next user
        input("\nPress Enter to see next user's query...")

def interactive_mode():
    """
    Interactive mode: ask your own queries
    """
    
    print("="*70)
    print("🛸 ORBIT - Interactive Query Mode")
    print("="*70)
    
    db = Database()
    agent = ORBITAgent()
    viz = ORBITVisualizer()
    
    # pick a user
    print("\nAvailable users:")
    print("1. usr_001 - budget_bob (price sensitive)")
    print("2. usr_002 - performance_paula (spec junkie)")
    print("3. usr_003 - apple_andy (brand loyal)")
    print("4. usr_004 - balanced_beth (balanced buyer)")
    
    user_choice = input("\nSelect user (1-4): ").strip()
    user_map = {
        "1": ("usr_001", "budget_bob"),
        "2": ("usr_002", "performance_paula"),
        "3": ("usr_003", "apple_andy"),
        "4": ("usr_004", "balanced_beth")
    }
    
    user_id, username = user_map.get(user_choice, ("usr_001", "budget_bob"))
    
    print(f"\n👤 Selected: {username}")
    
    while True:
        query = input("\n💬 Enter your query (or 'quit' to exit): ").strip()
        
        if query.lower() in ['quit', 'exit', 'q']:
            print("Goodbye!")
            break
        
        if not query:
            continue
        
        # determine category from query (simple heuristic)
        query_lower = query.lower()
        if any(word in query_lower for word in ['laptop', 'computer', 'pc']):
            category_id = "cat_laptops"
        elif any(word in query_lower for word in ['phone', 'smartphone', 'iphone', 'android']):
            category_id = "cat_phones"
        elif any(word in query_lower for word in ['coffee', 'beans', 'roast']):
            category_id = "cat_coffee"
        elif any(word in query_lower for word in ['shoe', 'sneaker', 'shoes']):
            category_id = "cat_sneakers"
        else:
            category_id = "cat_laptops"  # default
        
        # fetch data
        purchase_history = db.get_user_purchase_history(user_id)
        products = db.search_products(category_id)
        
        # run agent
        ranked_results, user_profile = agent.run_query(
            user_id=user_id,
            query=query,
            purchase_history=purchase_history,
            candidate_products=products
        )
        
        # show results
        print(f"\n🎯 Top 3 Recommendations:")
        for i, result in enumerate(ranked_results[:3], 1):
            print(f"{i}. {result.product.product_name} - ${result.product.base_price:.2f} (Score: {result.ahp_score:.3f})")
        
        # ask if they want visualizations
        viz_choice = input("\nGenerate visualizations? (y/n): ").strip().lower()
        if viz_choice == 'y':
            viz.generate_full_report(ranked_results, user_profile, f"{username}_custom")
            print(f"✅ Saved to ./output/{username}_custom_*.png")

def quick_test():
    """Quick test to verify everything works"""
    print("🧪 Running quick test...\n")
    
    db = Database()
    agent = ORBITAgent()
    
    user_id = "usr_001"
    query = "I need a cheap laptop under $700"
    
    purchases = db.get_user_purchase_history(user_id)
    products = db.search_products("cat_laptops")
    
    results, profile = agent.run_query(
        user_id=user_id,
        query=query,
        purchase_history=purchases,
        candidate_products=products[:5]
    )
    
    print(f"\n✅ Test passed!")
    print(f"Top pick: {results[0].product.product_name}")
    print(f"Score: {results[0].ahp_score:.3f}")

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1:
        if sys.argv[1] == "test":
            quick_test()
        elif sys.argv[1] == "interactive":
            interactive_mode()
        else:
            demo_orbit_system()
    else:
        # default: run demo
        demo_orbit_system()