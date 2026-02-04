from fastapi import APIRouter
from typing import List
import json
from pathlib import Path

router = APIRouter(prefix="/api/recipes", tags=["recipes"])

RECIPE_DATA_PATH = Path(__file__).resolve().parents[2] / "knowledge" / "recipes.json"

@router.get("/search")
async def search_recipes(query: str = ""):
    """
    Search for recipes (MVP: return mock data)
    """
    # Mock data - replace with RecipeDB API call
    with RECIPE_DATA_PATH.open() as f:
        recipes = json.load(f)
    
    q = query.strip().lower()
    if q:
        recipes = [r for r in recipes if r["name"].lower().startswith(q)]
    
    return {"recipes": recipes}

@router.get("/{recipe_id}")
async def get_recipe(recipe_id: str):
    """Get recipe by ID"""
    # Mock - replace with DB
    return {
        "id": recipe_id,
        "name": "Sample Recipe",
        "ingredients": [],
        "instructions": []
    }
