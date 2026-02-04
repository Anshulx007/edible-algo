"""API Schema: Recipe DTO"""
from pydantic import BaseModel
from typing import List

class IngredientDTO(BaseModel):
    name: str
    amount: str | None = None

class RecipeDTO(BaseModel):
    id: str
    name: str
    ingredients: List[IngredientDTO]
    steps: List[str]
