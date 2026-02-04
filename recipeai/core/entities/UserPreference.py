from dataclasses import dataclass
from typing import Dict, List


@dataclass
class UserPreference:
    user_id: str
    dietary_type: str  # 'vegan', 'vegetarian', 'non-veg'
    allergens: List[str]
    blocked_ingredients: List[str]
    flavor_preferences: Dict[str, float]  # {'spicy': 0.8, 'sweet': 0.3}
