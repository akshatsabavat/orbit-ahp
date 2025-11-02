import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import pandas as pd
from typing import Dict, List
from models import RankedProduct, UserProfile
from ahp_matrix_viz import AHPMatrixVisualizer
import os


# set style
sns.set_style("whitegrid")
plt.rcParams['figure.figsize'] = (12, 8)
matrix_viz = AHPMatrixVisualizer()


class ORBITVisualizer:
    """
    Makes the demo look sick with graphs
    Judges love visuals
    """
    
    def __init__(self, output_dir="./output"):
        self.output_dir = output_dir
        os.makedirs(output_dir, exist_ok=True)
    
    def plot_criteria_weights(self, user_profile: UserProfile, user_name: str):
        """
        Bar chart showing what the user values
        E.g., Budget Bob has 60% price weight
        """
        criteria = [w.criteria_name for w in user_profile.criteria_weights]
        weights = [w.weight for w in user_profile.criteria_weights]
        confidence = [w.confidence for w in user_profile.criteria_weights]
        
        fig, ax = plt.subplots(figsize=(10, 6))
        
        bars = ax.bar(criteria, weights, color='steelblue', alpha=0.8, edgecolor='black')
        
        # add confidence as error bars
        ax.errorbar(criteria, weights, yerr=[1-c for c in confidence], 
                   fmt='none', ecolor='red', capsize=5, alpha=0.6, label='Uncertainty')
        
        ax.set_ylabel('Weight', fontsize=12, fontweight='bold')
        ax.set_xlabel('Criteria', fontsize=12, fontweight='bold')
        ax.set_title(f'{user_name} - Derived AHP Criteria Weights\n(from purchase history)', 
                    fontsize=14, fontweight='bold')
        ax.set_ylim(0, max(weights) * 1.2)
        
        # add value labels on bars
        for bar in bars:
            height = bar.get_height()
            ax.text(bar.get_x() + bar.get_width()/2., height,
                   f'{height:.2f}',
                   ha='center', va='bottom', fontweight='bold')
        
        ax.legend()
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{user_name}_criteria_weights.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        print(f"   📊 Saved: {user_name}_criteria_weights.png")
    
    def plot_ahp_comparison_matrix(self, ranked_products: List[RankedProduct], user_name: str):
        """
        Heatmap showing how products compare on each criteria
        Classic AHP visualization
        """
        if not ranked_products:
            return
        
        # build matrix: products x criteria
        products = [p.product.product_name[:20] for p in ranked_products[:8]]  # top 8
        criteria = list(ranked_products[0].criteria_scores.keys())
        
        matrix = []
        for prod in ranked_products[:8]:
            matrix.append([prod.criteria_scores[c] for c in criteria])
        
        df = pd.DataFrame(matrix, index=products, columns=criteria)
        
        fig, ax = plt.subplots(figsize=(10, 8))
        sns.heatmap(df, annot=True, fmt='.2f', cmap='RdYlGn', 
                   cbar_kws={'label': 'Score (0-1)'}, ax=ax,
                   linewidths=0.5, linecolor='gray')
        
        ax.set_title(f'{user_name} - Product Criteria Scores\n(AHP Comparison Matrix)', 
                    fontsize=14, fontweight='bold')
        ax.set_xlabel('Criteria', fontsize=12, fontweight='bold')
        ax.set_ylabel('Products', fontsize=12, fontweight='bold')
        
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{user_name}_comparison_matrix.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        print(f"   📊 Saved: {user_name}_comparison_matrix.png")
    
    def plot_final_rankings(self, ranked_products: List[RankedProduct], user_name: str):
        """
        Horizontal bar chart showing final AHP scores
        Color coded to show clear winner
        """
        if not ranked_products:
            return
        
        products = [p.product.product_name[:30] for p in ranked_products[:10]]
        scores = [p.ahp_score for p in ranked_products[:10]]
        prices = [p.product.base_price for p in ranked_products[:10]]
        
        fig, ax = plt.subplots(figsize=(12, 8))
        
        # color bars by score
        colors = plt.cm.RdYlGn(np.array(scores) / max(scores))
        bars = ax.barh(products, scores, color=colors, edgecolor='black', linewidth=1.5)
        
        ax.set_xlabel('AHP Score', fontsize=12, fontweight='bold')
        ax.set_title(f'{user_name} - Final Product Rankings\n(Higher = Better Match)', 
                    fontsize=14, fontweight='bold')
        ax.set_xlim(0, max(scores) * 1.1)
        
        # add score and price labels
        for i, (bar, score, price) in enumerate(zip(bars, scores, prices)):
            width = bar.get_width()
            ax.text(width, bar.get_y() + bar.get_height()/2,
                   f' {score:.3f} | ${price:.0f}',
                   ha='left', va='center', fontweight='bold', fontsize=9)
        
        # highlight #1 pick
        bars[0].set_edgecolor('gold')
        bars[0].set_linewidth(3)
        
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{user_name}_final_rankings.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        print(f"   📊 Saved: {user_name}_final_rankings.png")
    
    def plot_sensitivity_analysis(self, ranked_products: List[RankedProduct], 
                                  user_profile: UserProfile, user_name: str):
        """
        Shows how rankings change if we tweak criteria weights
        "What if price was more/less important?"
        This is GOLD for demos
        """
        if not ranked_products or len(ranked_products) < 3:
            return
        
        # pick top 5 products
        top_products = ranked_products[:5]
        product_names = [p.product.product_name[:15] for p in top_products]
        
        # pick main criteria to vary (usually first one with high weight)
        main_criteria = max(user_profile.criteria_weights, key=lambda x: x.weight).criteria_name
        original_weight = next(w.weight for w in user_profile.criteria_weights if w.criteria_name == main_criteria)
        
        # vary weight from 0.1 to 0.9
        weight_range = np.linspace(0.1, 0.9, 20)
        
        # recalculate scores for each weight
        sensitivity_scores = {name: [] for name in product_names}
        
        for new_weight in weight_range:
            # adjust other weights proportionally
            remaining = 1 - new_weight
            other_criteria = [w for w in user_profile.criteria_weights if w.criteria_name != main_criteria]
            total_other = sum(w.weight for w in other_criteria)
            
            # calculate new scores
            for prod in top_products:
                score = new_weight * prod.criteria_scores.get(main_criteria, 0)
                for crit in other_criteria:
                    adjusted_weight = (crit.weight / total_other) * remaining if total_other > 0 else 0
                    score += adjusted_weight * prod.criteria_scores.get(crit.criteria_name, 0)
                
                sensitivity_scores[prod.product.product_name[:15]].append(score)
        
        # plot
        fig, ax = plt.subplots(figsize=(12, 8))
        
        for name, scores in sensitivity_scores.items():
            ax.plot(weight_range, scores, marker='o', linewidth=2, label=name, markersize=4)
        
        # mark original weight
        ax.axvline(original_weight, color='red', linestyle='--', linewidth=2, 
                  label=f'Current Weight: {original_weight:.2f}', alpha=0.7)
        
        ax.set_xlabel(f'{main_criteria.capitalize()} Weight', fontsize=12, fontweight='bold')
        ax.set_ylabel('AHP Score', fontsize=12, fontweight='bold')
        ax.set_title(f'{user_name} - Sensitivity Analysis\n(How rankings change if "{main_criteria}" weight varies)', 
                    fontsize=14, fontweight='bold')
        ax.legend(loc='best', fontsize=9)
        ax.grid(True, alpha=0.3)
        
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{user_name}_sensitivity.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        print(f"   📊 Saved: {user_name}_sensitivity.png")
    
    def plot_criteria_radar(self, ranked_products: List[RankedProduct], user_name: str):
        """
        Radar chart comparing top 3 products across all criteria
        Looks sick, judges love these
        """
        if not ranked_products or len(ranked_products) < 3:
            return
        
        top_3 = ranked_products[:3]
        criteria = list(top_3[0].criteria_scores.keys())
        
        # setup radar chart
        angles = np.linspace(0, 2 * np.pi, len(criteria), endpoint=False).tolist()
        angles += angles[:1]  # close the circle
        
        fig, ax = plt.subplots(figsize=(10, 10), subplot_kw=dict(projection='polar'))
        
        colors = ['#1f77b4', '#ff7f0e', '#2ca02c']
        
        for i, prod in enumerate(top_3):
            values = [prod.criteria_scores[c] for c in criteria]
            values += values[:1]  # close the circle
            
            ax.plot(angles, values, 'o-', linewidth=2, label=prod.product.product_name[:20], 
                   color=colors[i])
            ax.fill(angles, values, alpha=0.15, color=colors[i])
        
        ax.set_xticks(angles[:-1])
        ax.set_xticklabels([c.capitalize() for c in criteria], fontsize=11)
        ax.set_ylim(0, 1)
        ax.set_yticks([0.2, 0.4, 0.6, 0.8, 1.0])
        ax.set_yticklabels(['0.2', '0.4', '0.6', '0.8', '1.0'], fontsize=9)
        ax.grid(True)
        
        ax.set_title(f'{user_name} - Top 3 Products Comparison\n(Radar Chart)', 
                    fontsize=14, fontweight='bold', pad=20)
        ax.legend(loc='upper right', bbox_to_anchor=(1.3, 1.1), fontsize=10)
        
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{user_name}_radar.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        print(f"   📊 Saved: {user_name}_radar.png")
    
    def plot_price_vs_score(self, ranked_products: List[RankedProduct], user_name: str):
        """
        Scatter plot: AHP score vs price
        Shows value-for-money sweet spot
        """
        if not ranked_products:
            return
        
        prices = [p.product.base_price for p in ranked_products[:15]]
        scores = [p.ahp_score for p in ranked_products[:15]]
        names = [p.product.product_name[:20] for p in ranked_products[:15]]
        
        fig, ax = plt.subplots(figsize=(12, 8))
        
        scatter = ax.scatter(prices, scores, s=200, c=scores, cmap='RdYlGn', 
                           edgecolors='black', linewidth=1.5, alpha=0.7)
        
        # annotate top 3
        for i in range(min(3, len(names))):
            ax.annotate(names[i], (prices[i], scores[i]), 
                       xytext=(10, 10), textcoords='offset points',
                       fontsize=9, fontweight='bold',
                       bbox=dict(boxstyle='round,pad=0.5', facecolor='yellow', alpha=0.7),
                       arrowprops=dict(arrowstyle='->', connectionstyle='arc3,rad=0'))
        
        ax.set_xlabel('Price ($)', fontsize=12, fontweight='bold')
        ax.set_ylabel('AHP Score', fontsize=12, fontweight='bold')
        ax.set_title(f'{user_name} - Value Analysis\n(Score vs Price)', 
                    fontsize=14, fontweight='bold')
        
        plt.colorbar(scatter, ax=ax, label='AHP Score')
        ax.grid(True, alpha=0.3)
        
        plt.tight_layout()
        plt.savefig(f'{self.output_dir}/{user_name}_value_analysis.png', dpi=300, bbox_inches='tight')
        plt.close()
        
        print(f"   📊 Saved: {user_name}_value_analysis.png")
    
    def generate_full_report(self, ranked_products: List[RankedProduct], 
                           user_profile: UserProfile, user_name: str, ahp_matrices: Dict):
        """
        Generate all visualizations for a user
        Call this once and get all the graphs
        """
        print(f"\n📈 Generating visualizations for {user_name}...")
        
        self.plot_criteria_weights(user_profile, user_name)
        self.plot_ahp_comparison_matrix(ranked_products, user_name)
        self.plot_final_rankings(ranked_products, user_name)
        self.plot_sensitivity_analysis(ranked_products, user_profile, user_name)
        self.plot_criteria_radar(ranked_products, user_name)
        self.plot_price_vs_score(ranked_products, user_name)
        matrix_viz.generate_all_matrices(ahp_matrices, user_name)
        
        print(f"✅ All visualizations saved to {self.output_dir}/")
        print(f"   Open them to see the AHP magic!\n")