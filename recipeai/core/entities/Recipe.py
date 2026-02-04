from dataclasses import dataclass
from typing import List

@dataclass
class Ingredient:
    name: str
    quantity: str
    unit: str
    categories: List[str]  # ['vegan', 'protein', 'dairy']
    
@dataclass
class Recipe:
    id: str
    name: str
    ingredients: List[Ingredient]
    instructions: List[str]
    cuisine: str
    dietary_tags: List[str]  # ['vegan', 'gluten-free']