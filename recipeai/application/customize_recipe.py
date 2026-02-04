from __future__ import annotations

from pathlib import Path
from typing import List

from ..core.entities.Recipe import Recipe, Ingredient
from ..core.entities.UserPreference import UserPreference
from .substitute_ingredient import SubstituteIngredient
import json

class CustomizeRecipe:
    def __init__(self):
        self.substitutor = SubstituteIngredient()
        allergen_path = Path(__file__).resolve().parents[1] / "knowledge" / "allergen_map.json"
        with allergen_path.open() as f:
            self.allergens = json.load(f)
    
    def execute(self, recipe: Recipe, preferences: UserPreference) -> dict:
        """
        Customize recipe based on user preferences
        """
        modified_ingredients = []
        substitutions_made = []
        
        for ingredient in recipe.ingredients:
            # Check allergens (hard filter)
            if self._is_allergen(ingredient.name, preferences.allergens):
                continue  # Skip allergenic ingredients
            
            # Check dietary constraints
            if self._violates_diet(ingredient, preferences.dietary_type):
                # Find substitute
                sub = self.substitutor.execute(
                    ingredient.name,
                    preferences.dietary_type,
                    [i.name for i in recipe.ingredients]
                )
                
                if sub['substitute']:
                    modified_ing = Ingredient(
                        name=sub['substitute'],
                        quantity=ingredient.quantity,
                        unit=ingredient.unit,
                        categories=ingredient.categories
                    )
                    modified_ingredients.append(modified_ing)
                    substitutions_made.append(sub)
                # else: ingredient removed, no substitute
            else:
                # Keep original ingredient
                modified_ingredients.append(ingredient)
        
        # Adjust flavors (simple MVP: just add spices)
        if preferences.flavor_preferences.get('spicy', 0) > 0.5:
            modified_ingredients.append(
                Ingredient('chili flakes', '1', 'tsp', ['vegan', 'spice'])
            )
        
        return {
            'original_recipe': recipe,
            'modified_ingredients': modified_ingredients,
            'substitutions': substitutions_made,
            'instructions': recipe.instructions,  # Keep same for MVP
            'customization_summary': self._generate_summary(substitutions_made)
        }
    
    def _is_allergen(self, ingredient: str, allergens: List[str]) -> bool:
        for allergen in allergens:
            if ingredient.lower() in self.allergens.get(allergen, []):
                return True
        return False
    
    def _violates_diet(self, ingredient: Ingredient, diet_type: str) -> bool:
        if diet_type == 'vegan':
            blocked = ['meat', 'dairy', 'eggs', 'animal-product']
        elif diet_type == 'vegetarian':
            blocked = ['meat', 'seafood']
        else:
            return False
        
        return any(cat in ingredient.categories for cat in blocked)
    
    def _generate_summary(self, substitutions: List[dict]) -> str:
        if not substitutions:
            return "No substitutions needed"
        
        summary = f"Made {len(substitutions)} substitutions:\n"
        for sub in substitutions:
            summary += f"- {sub['original']} → {sub['substitute']}\n"
        return summary
