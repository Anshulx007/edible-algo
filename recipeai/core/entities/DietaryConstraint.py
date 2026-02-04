@dataclass
class DietaryConstraint:
    type: str  # 'vegan', 'vegetarian', etc.
    blocked_categories: List[str]
    allowed_categories: List[str]