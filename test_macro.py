"""
TEST MACRO SYSTEM
Simple test script for vendor strategic analysis

DELETE THIS LATER IF NEEDED
"""

from dotenv import load_dotenv
load_dotenv()

from db import Database
from macro_ahp_engine import ORBITMacroAgent
from macro_visualizer import ORBITMacroVisualizer

def test_macro():
    """Test macro system with TechBuy"""
    
    print("="*70)
    print("🛸 ORBIT MACRO TEST")
    print("="*70)
    
    db = Database()
    agent = ORBITMacroAgent() 
    viz = ORBITMacroVisualizer()
    
    vendor_id = "vnd_techbuy"
    category = "cat_laptops"
    
    print(f"\n🏢 Analyzing: {vendor_id} in {category}")
    
    print("\n📊 Fetching vendor data...")
    
    result = db.supabase.table('vendor_strategic_insights').select(
        '*, vendors(*)'
    ).eq('vendor_id', vendor_id).eq('category_id', category).execute()
    
    if not result.data:
        print("❌ No vendor data found!")
        return
    
    insight = result.data[0]
    vendor_name = insight['vendors']['vendor_name'] if insight.get('vendors') else vendor_id
    
    from models import VendorProfile
    
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
    
    print(f"   Vendor: {vendor_profile.vendor_name}")
    print(f"   Market Share: {vendor_profile.market_share*100:.1f}%")
    
    print("\n   Customer Base:")
    for seg, pct in vendor_profile.customer_segments.items():
        print(f"   - {seg}: {pct*100:.0f}%")
    
    # Run AHP analysis
    print("\n🤖 Running AHP strategic analysis...")
    ranked_alternatives, criteria, ahp_matrices = agent.run_strategic_analysis(vendor_profile)
    
    print(f"\n🎯 TOP 5 STRATEGIES:")
    for alt in ranked_alternatives[:5]:
        print(f"   {alt.rank}. {alt.alternative.name} - Score: {alt.ahp_score:.3f}")
    
    # BOCR
    print(f"\n⚖️  Generating BOCR...")
    bocr = agent.generate_bocr(ranked_alternatives[0], vendor_profile)
    
    print(f"\n   Strategy: {bocr.alternative_name}")
    print(f"   Benefits: {bocr.total_benefits:.2f}")
    print(f"   Opportunities: {bocr.total_opportunities:.2f}")
    print(f"   Costs: {bocr.total_costs:.2f}")
    print(f"   Risks: {bocr.total_risks:.2f}")
    print(f"   Net Score: {bocr.net_score:.2f}")
    
    # AI Narrative (using Gemini!)
    print(f"\n🤖 Generating strategic narrative with Gemini...")
    narrative = agent.generate_strategic_narrative(
        vendor_profile,
        ranked_alternatives,
        criteria,
        bocr
    )
    
    print(f"\n{'='*70}")
    print("📋 STRATEGIC RECOMMENDATION")
    print(f"{'='*70}")
    print(narrative)
    
    # Visualizations
    print(f"\n📈 Generating visualizations...")
    viz.plot_final_rankings(ranked_alternatives, vendor_profile.vendor_name)
    viz.plot_bocr_analysis(bocr, vendor_profile.vendor_name)
    viz.plot_customer_segments(vendor_profile, vendor_profile.vendor_name)
    
    print(f"\n✅ Test complete!")
    print(f"   Check ./output/macro/ for visualizations")

if __name__ == "__main__":
    test_macro()