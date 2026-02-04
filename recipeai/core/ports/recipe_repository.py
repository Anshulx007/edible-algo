"""Port: Recipe repository interface"""
from abc import ABC, abstractmethod
from typing import List

from ..entities.Recipe import Recipe

class RecipeRepository(ABC):
    @abstractmethod
    def get(self, recipe_id: str) -> Recipe | None:
        raise NotImplementedError

    @abstractmethod
    def search(self, query: str) -> List[Recipe]:
        raise NotImplementedError
