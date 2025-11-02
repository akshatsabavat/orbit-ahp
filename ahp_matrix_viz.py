import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np
from pathlib import Path

class AHPMatrixVisualizer:
    """
    Creates visualizations of AHP matrices for academic/judge presentation
    Shows the actual comparison matrices and decision hierarchy
    """
    
    def __init__(self, output_dir="./output"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
    def save_criteria_weights_table(self, ahp_matrices: dict, username: str):
        """
        Save criteria weights as a clean table image
        """
        criteria_weights = ahp_matrices['criteria_weights']
        
        fig, ax = plt.subplots(figsize=(10, 6))
        ax.axis('tight')
        ax.axis('off')
        
        # prepare data
        data = [[c, f"{w:.4f}", f"{w*100:.1f}%"] 
                for c, w in sorted(criteria_weights.items(), key=lambda x: x[1], reverse=True)]
        
        table = ax.table(cellText=data, 
                        colLabels=['Criteria', 'Weight', 'Percentage'],
                        cellLoc='left',
                        loc='center',
                        colWidths=[0.5, 0.25, 0.25])
        
        table.auto_set_font_size(False)
        table.set_fontsize(11)
        table.scale(1, 2)
        
        # style header
        for i in range(3):
            table[(0, i)].set_facecolor('#4472C4')
            table[(0, i)].set_text_props(weight='bold', color='white')
        
        # alternate row colors
        for i in range(1, len(data) + 1):
            color = '#E7E6E6' if i % 2 == 0 else 'white'
            for j in range(3):
                table[(i, j)].set_facecolor(color)
        
        plt.title(f"AHP Criteria Weights - {username}", 
                 fontsize=14, fontweight='bold', pad=20)
        
        filename = self.output_dir / f"{username}_ahp_criteria_weights.png"
        plt.savefig(filename, bbox_inches='tight', dpi=300)
        plt.close()
        
        return filename
    
    def save_product_scores_matrix(self, ahp_matrices: dict, username: str, top_n=10):
        """
        Save product scores as heatmap matrix
        Shows how each product scored on each criteria
        """
        product_scores = ahp_matrices['product_scores']
        criteria = ahp_matrices['criteria']
        
        # limit to top N products by final score
        final_scores = ahp_matrices['final_scores']
        top_products = sorted(final_scores.items(), key=lambda x: x[1], reverse=True)[:top_n]
        top_product_ids = [p[0] for p in top_products]
        
        # build matrix
        matrix_data = []
        product_names = []
        
        for prod_id in top_product_ids:
            if prod_id in product_scores:
                scores = product_scores[prod_id]
                row = [scores.get(c, 0) for c in criteria]
                matrix_data.append(row)
                # shorten product name
                product_names.append(prod_id.replace('prod_', '').replace('_', ' ')[:15])
        
        df = pd.DataFrame(matrix_data, columns=criteria, index=product_names)
        
        # create heatmap
        fig, ax = plt.subplots(figsize=(12, 8))
        sns.heatmap(df, annot=True, fmt='.3f', cmap='RdYlGn', 
                   linewidths=0.5, ax=ax, vmin=0, vmax=1,
                   cbar_kws={'label': 'Score (0-1)'})
        
        plt.title(f"Product Criteria Scores Matrix - {username}\n(Top {top_n} Products)", 
                 fontsize=14, fontweight='bold', pad=20)
        plt.xlabel('Criteria', fontsize=12, fontweight='bold')
        plt.ylabel('Products', fontsize=12, fontweight='bold')
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout()
        
        filename = self.output_dir / f"{username}_ahp_score_matrix.png"
        plt.savefig(filename, bbox_inches='tight', dpi=300)
        plt.close()
        
        return filename
    
    def save_decision_hierarchy(self, ahp_matrices: dict, username: str):
        """
        Visualize the AHP decision hierarchy
        Goal → Criteria → Products
        """
        fig, ax = plt.subplots(figsize=(14, 10))
        ax.set_xlim(0, 10)
        ax.set_ylim(0, 10)
        ax.axis('off')
        
        # goal box
        goal_text = f"Select Best Product\n({ahp_matrices['query_context'].get('use_case', 'general')})"
        ax.add_patch(plt.Rectangle((4, 8.5), 2, 1, 
                                   facecolor='#4472C4', edgecolor='black', linewidth=2))
        ax.text(5, 9, goal_text, ha='center', va='center', 
               fontsize=11, fontweight='bold', color='white')
        
        # criteria boxes
        criteria = ahp_matrices['criteria']
        criteria_weights = ahp_matrices['criteria_weights']
        n_criteria = len(criteria)
        spacing = 8 / (n_criteria + 1)
        
        for i, criterion in enumerate(criteria):
            x = 1 + spacing * (i + 1)
            weight = criteria_weights[criterion]
            
            # box
            color = '#70AD47' if weight > 0.25 else '#FFC000' if weight > 0.15 else '#A5A5A5'
            ax.add_patch(plt.Rectangle((x - 0.4, 6), 0.8, 0.8,
                                      facecolor=color, edgecolor='black', linewidth=1.5))
            ax.text(x, 6.4, criterion.replace('_', '\n'), ha='center', va='center',
                   fontsize=9, fontweight='bold')
            ax.text(x, 5.7, f"{weight:.3f}", ha='center', va='center',
                   fontsize=8, color='#333333')
            
            # line from goal to criterion
            ax.plot([5, x], [8.5, 6.8], 'k-', linewidth=1, alpha=0.5)
        
        # top products
        final_scores = ahp_matrices['final_scores']
        top_products = sorted(final_scores.items(), key=lambda x: x[1], reverse=True)[:5]
        
        for i, (prod_id, score) in enumerate(top_products):
            x = 1.5 + i * 1.7
            ax.add_patch(plt.Rectangle((x - 0.3, 3.8), 0.6, 0.6,
                                      facecolor='#E7E6E6', edgecolor='black', linewidth=1))
            ax.text(x, 4.1, f"#{i+1}", ha='center', va='center',
                   fontsize=8, fontweight='bold')
            ax.text(x, 3.5, f"{score:.3f}", ha='center', va='center',
                   fontsize=7)
            
            # lines from criteria to products
            for j, criterion in enumerate(criteria):
                cx = 1 + spacing * (j + 1)
                ax.plot([cx, x], [6, 4.4], 'k-', linewidth=0.3, alpha=0.3)
        
        plt.title(f"AHP Decision Hierarchy - {username}", 
                 fontsize=16, fontweight='bold', pad=20)
        
        # legend
        ax.text(0.5, 1.5, "Criteria Weight:", fontsize=9, fontweight='bold')
        ax.add_patch(plt.Rectangle((0.5, 1), 0.3, 0.2, facecolor='#70AD47'))
        ax.text(0.9, 1.1, "> 0.25 (High)", fontsize=8, va='center')
        ax.add_patch(plt.Rectangle((2, 1), 0.3, 0.2, facecolor='#FFC000'))
        ax.text(2.4, 1.1, "0.15-0.25 (Med)", fontsize=8, va='center')
        ax.add_patch(plt.Rectangle((3.7, 1), 0.3, 0.2, facecolor='#A5A5A5'))
        ax.text(4.1, 1.1, "< 0.15 (Low)", fontsize=8, va='center')
        
        filename = self.output_dir / f"{username}_ahp_hierarchy.png"
        plt.savefig(filename, bbox_inches='tight', dpi=300)
        plt.close()
        
        return filename
    
    def save_criteria_comparison_matrix(self, ahp_matrices: dict, username: str):
        """
        Save simulated pairwise comparison matrix
        This shows how criteria were compared against each other
        """
        criteria_weights = ahp_matrices['criteria_weights']
        criteria = list(criteria_weights.keys())
        n = len(criteria)
        
        # build pairwise comparison matrix from weights
        # A[i][j] = weight[i] / weight[j] (Saaty's ratio)
        matrix = np.zeros((n, n))
        for i in range(n):
            for j in range(n):
                if criteria_weights[criteria[j]] > 0:
                    matrix[i][j] = criteria_weights[criteria[i]] / criteria_weights[criteria[j]]
                else:
                    matrix[i][j] = 1.0
        
        df = pd.DataFrame(matrix, columns=criteria, index=criteria)
        
        # create heatmap
        fig, ax = plt.subplots(figsize=(10, 8))
        sns.heatmap(df, annot=True, fmt='.2f', cmap='coolwarm', 
                   linewidths=0.5, ax=ax, center=1.0,
                   cbar_kws={'label': 'Importance Ratio'})
        
        plt.title(f"Criteria Pairwise Comparison Matrix - {username}\n(Derived from AHP Weights)", 
                 fontsize=14, fontweight='bold', pad=20)
        plt.xlabel('Criteria (Column)', fontsize=11, fontweight='bold')
        plt.ylabel('Criteria (Row)', fontsize=11, fontweight='bold')
        plt.xticks(rotation=45, ha='right')
        plt.yticks(rotation=0)
        
        # add explanation text
        fig.text(0.5, 0.02, 
                "Values > 1: Row criterion more important than column\n" +
                "Values < 1: Column criterion more important than row\n" +
                "Values = 1: Equal importance",
                ha='center', fontsize=9, style='italic', color='#666666')
        
        plt.tight_layout()
        
        filename = self.output_dir / f"{username}_ahp_pairwise_matrix.png"
        plt.savefig(filename, bbox_inches='tight', dpi=300)
        plt.close()
        
        return filename
    
    def generate_all_matrices(self, ahp_matrices: dict, username: str):
        """
        Generate all AHP matrix visualizations
        """
        print(f"\n📊 Generating AHP matrices for {username}...")
        
        files = []
        
        # 1. Criteria weights table
        f = self.save_criteria_weights_table(ahp_matrices, username)
        files.append(f)
        print(f"   ✓ Criteria weights table: {f.name}")
        
        # 2. Product scores matrix
        f = self.save_product_scores_matrix(ahp_matrices, username)
        files.append(f)
        print(f"   ✓ Product scores matrix: {f.name}")
        
        # 3. Decision hierarchy
        f = self.save_decision_hierarchy(ahp_matrices, username)
        files.append(f)
        print(f"   ✓ Decision hierarchy: {f.name}")
        
        # 4. Pairwise comparison matrix
        f = self.save_criteria_comparison_matrix(ahp_matrices, username)
        files.append(f)
        print(f"   ✓ Pairwise comparison matrix: {f.name}")
        
        return files