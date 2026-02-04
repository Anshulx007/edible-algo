"""Explainability: nutrition explainer"""
def explain_nutrition(nutrition: dict) -> str:
    return "Estimated calories: {}".format(nutrition.get('calories', 'unknown'))
