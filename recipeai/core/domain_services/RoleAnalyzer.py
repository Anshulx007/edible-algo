"""Domain service: RoleAnalyzer"""
class RoleAnalyzer:
    def analyze_role(self, ingredient_name: str) -> str:
        """Return an inferred role for an ingredient (e.g., main, binder)."""
        return "main"
