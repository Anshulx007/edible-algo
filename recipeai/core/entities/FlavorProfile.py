"""Domain entity: FlavorProfile"""
from dataclasses import dataclass
from typing import Dict

@dataclass
class FlavorProfile:
    notes: Dict[str, float]  # e.g., {"sweet": 0.7, "umami": 0.4}
