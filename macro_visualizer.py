"""
MACRO VISUALIZER
Add to your existing visualizer setup
"""

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd
from typing import Dict, List
from models import RankedAlternative, VendorProfile, StrategicCriteria, BOCRAnalysis
import os

sns.set_style("whitegrid")

class ORBITMacroVisualizer:
    """Visualizations for vendor strategy"""
    
    def __init__(self, output_dir="./output/macro"):
        self.output_dir = output_dir
        os.makedirs(output_dir, exist_ok=True)
    
    def plot_final_rankings(self, ranked_alternatives: List[RankedAlternative], vendor_name: str):
        """Bar chart of strategic alternatives"""
        alternatives = [a.alternative.name for a in ranked_alternatives]
        scores = [a.ahp_score for a in ranked_alternatives]
        
        fig, ax = plt.subplots(figsize=(12, 8))
        colors = plt.cm.RdYlGn(np.array(scores) / max(scores))
        bars = ax.barh(alternatives, scores, color=colors, edgecolor='black', linewidth=1.5)
        
        ax.set_xlabel('AHP Score', fontsize=12, fontweight='bold')
        ax.set_title(f'{vendor_name} - Strategic Rankings',
                    fontsize=14, fontweight='bold')
        
        for bar, score in zip(bars, scores):
            width = bar.get_width()
            ax.text(width, bar.get_y() + bar.get_height()/2,
                   f' {score:.3f}', ha='left', va='center', fontweight='bold')
        
        bars[0].set_edgecolor('gold')
        bars[0].set_linewidth(3)
        
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{vendor_name}_rankings.png', dpi=300, bbox_inches='tight')
        plt.close()
        print(f"   📊 Saved: {vendor_name}_rankings.png")
    
    def plot_bocr_analysis(self, bocr: BOCRAnalysis, vendor_name: str):
        """BOCR quadrants"""
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))
        
        # Benefits
        if bocr.benefits:
            b_df = pd.DataFrame(list(bocr.benefits.items()), columns=['Item', 'Score'])
            ax1.barh(b_df['Item'], b_df['Score'], color='green', alpha=0.7)
            ax1.set_title('BENEFITS', fontweight='bold')
        
        # Opportunities
        if bocr.opportunities:
            o_df = pd.DataFrame(list(bocr.opportunities.items()), columns=['Item', 'Score'])
            ax2.barh(o_df['Item'], o_df['Score'], color='blue', alpha=0.7)
            ax2.set_title('OPPORTUNITIES', fontweight='bold')
        
        # Costs
        if bocr.costs:
            c_df = pd.DataFrame(list(bocr.costs.items()), columns=['Item', 'Score'])
            ax3.barh(c_df['Item'], c_df['Score'], color='orange', alpha=0.7)
            ax3.set_title('COSTS', fontweight='bold')
        
        # Risks
        if bocr.risks:
            r_df = pd.DataFrame(list(bocr.risks.items()), columns=['Item', 'Score'])
            ax4.barh(r_df['Item'], r_df['Score'], color='red', alpha=0.7)
            ax4.set_title('RISKS', fontweight='bold')
        
        plt.suptitle(f'{vendor_name} - BOCR Analysis\n{bocr.alternative_name}',
                    fontsize=16, fontweight='bold')
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{vendor_name}_bocr.png', dpi=300, bbox_inches='tight')
        plt.close()
        print(f"   📊 Saved: {vendor_name}_bocr.png")
    
    def plot_customer_segments(self, vendor_profile: VendorProfile, vendor_name: str):
        """Customer base composition"""
        fig, ax = plt.subplots(figsize=(10, 6))
        
        segments = list(vendor_profile.customer_segments.keys())
        percentages = [v * 100 for v in vendor_profile.customer_segments.values()]
        
        bars = ax.bar(segments, percentages, edgecolor='black', linewidth=1.5)
        ax.set_ylabel('Percentage (%)', fontweight='bold')
        ax.set_title(f'{vendor_name} - Customer Segments', fontweight='bold')
        
        for bar in bars:
            height = bar.get_height()
            ax.text(bar.get_x() + bar.get_width()/2., height,
                   f'{height:.0f}%', ha='center', va='bottom', fontweight='bold')
        
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{vendor_name}_segments.png', dpi=300, bbox_inches='tight')
        plt.close()
        print(f"   📊 Saved: {vendor_name}_segments.png")