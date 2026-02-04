"""Domain entity: Ingredient"""
from dataclasses import dataclass

@dataclass
class Ingredient:
    name: str
    amount: str | None = None
    role: str | None = None  # e.g., main, binder, seasoning
