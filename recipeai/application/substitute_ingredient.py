from __future__ import annotations

import json
from pathlib import Path
from typing import List

class SubstituteIngredient:
    def __init__(self):
        rules_path = Path(__file__).resolve().parents[1] / "knowledge" / "substitution_rules.json"
        with rules_path.open() as f:
            self.rules = json.load(f)
    
    def execute(self, ingredient: str, dietary_type: str, context: List[str]) -> dict:
        """
        Find substitute for ingredient based on dietary constraint
        """
        substitutes = self.rules.get(ingredient.lower(), {})
        options = substitutes.get(dietary_type, [])
        
        if not options:
            return {
                'original': ingredient,
                'substitute': None,
                'reason': 'No substitute found',
                'confidence': 0.0
            }
        
        # Simple: return first option (can enhance with ML later)
        best_substitute = options[0]
        
        return {
            'original': ingredient,
            'substitute': best_substitute,
            'reason': f'Common {dietary_type} alternative',
            'confidence': 0.8
        }
