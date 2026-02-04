"""Port: Flavor repository interface"""
from abc import ABC, abstractmethod
from typing import Dict

class FlavorRepository(ABC):
    @abstractmethod
    def get_flavor_profile(self, ingredient_name: str) -> Dict[str, float]:
        raise NotImplementedError
