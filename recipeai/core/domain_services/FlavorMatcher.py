"""Domain service: FlavorMatcher"""
from typing import Dict, List

class FlavorMatcher:
    def match(self, target: Dict[str, float], candidates: List[Dict[str, float]]):
        """Return ranked candidates by similarity to target"""
        # placeholder
        return sorted(candidates, key=lambda c: 0, reverse=True)
