from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List

from recipeai.application.customize_recipe import CustomizeRecipe
from recipeai.core.entities.Recipe import Recipe, Ingredient
from recipeai.core.entities.UserPreference import UserPreference

router = APIRouter(prefix="/api/customize", tags=["customize"])

class CustomizeRequest(BaseModel):
    recipe_id: str
    dietary_type: str
    allergens: List[str] = []
    blocked_ingredients: List[str] = []
    flavor_preferences: dict = {}

class CustomizeResponse(BaseModel):
    success: bool
    modified_recipe: dict
    substitutions: List[dict]
    summary: str

@router.post("/", response_model=CustomizeResponse)
async def customize_recipe(request: CustomizeRequest):
    """
    Customize a recipe based on dietary preferences
    """
    # Mock: Get recipe from database (implement later)
    # For MVP, use hardcoded sample recipe
    recipe = _get_sample_recipe(request.recipe_id)
    
    preferences = UserPreference(
        user_id="temp",
        dietary_type=request.dietary_type,
        allergens=request.allergens,
        blocked_ingredients=request.blocked_ingredients,
        flavor_preferences=request.flavor_preferences
    )
    
    customizer = CustomizeRecipe()
    result = customizer.execute(recipe, preferences)
    
    return CustomizeResponse(
        success=True,
        modified_recipe={
            'name': recipe.name,
            'ingredients': [
                {'name': i.name, 'quantity': i.quantity, 'unit': i.unit}
                for i in result['modified_ingredients']
            ],
            'instructions': result['instructions']
        },
        substitutions=result['substitutions'],
        summary=result['customization_summary']
    )

def _get_sample_recipe(recipe_id: str) -> Recipe:
    """Mock recipe - replace with DB call"""
    return Recipe(
        id="1",
        name="Chicken Pasta",
        ingredients=[
            Ingredient("chicken", "200", "g", ["meat", "protein"]),
            Ingredient("pasta", "300", "g", ["grain"]),
            Ingredient("parmesan", "50", "g", ["dairy"]),
            Ingredient("garlic", "3", "cloves", ["vegan", "aromatic"]),
            Ingredient("olive oil", "2", "tbsp", ["vegan", "fat"])
        ],
        instructions=[
            "Cook pasta according to package",
            "Sauté chicken in olive oil",
            "Add garlic and cook until fragrant",
            "Combine pasta and chicken",
            "Top with parmesan"
        ],
        cuisine="Italian",
        dietary_tags=[]
    )
