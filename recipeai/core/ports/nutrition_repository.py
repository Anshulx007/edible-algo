"""Port: Nutrition repository interface"""
from abc import ABC, abstractmethod
from typing import Dict

class NutritionRepository(ABC):
    @abstractmethod
    def get_nutrition(self, ingredient_name: str) -> Dict[str, float]:
        raise NotImplementedError
