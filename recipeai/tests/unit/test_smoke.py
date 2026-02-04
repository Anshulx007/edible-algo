import pytest
from recipeai.application.substitute_ingredient import SubstituteIngredient
from recipeai.application.customize_recipe import CustomizeRecipe
from recipeai.core.entities.Recipe import Recipe, Ingredient
from recipeai.core.entities.UserPreference import UserPreference

def test_substitute_ingredient():
    """Test basic substitution"""
    substitutor = SubstituteIngredient()
    result = substitutor.execute('chicken', 'vegan', [])
    
    assert result['substitute'] in ['tofu', 'tempeh', 'chickpeas']
    assert result['confidence'] > 0.0

def test_customize_vegan_recipe():
    """Test full recipe customization for vegan"""
    recipe = Recipe(
        id="1",
        name="Test Pasta",
        ingredients=[
            Ingredient("chicken", "200", "g", ["meat"]),
            Ingredient("pasta", "300", "g", ["grain"]),
            Ingredient("parmesan", "50", "g", ["dairy"])
        ],
        instructions=["Cook", "Serve"],
        cuisine="Italian",
        dietary_tags=[]
    )
    
    preferences = UserPreference(
        user_id="test",
        dietary_type="vegan",
        allergens=[],
        blocked_ingredients=[],
        flavor_preferences={}
    )
    
    customizer = CustomizeRecipe()
    result = customizer.execute(recipe, preferences)
    
    # Check substitutions were made
    assert len(result['substitutions']) >= 2
    
    # Verify no animal products
    ing_names = [i.name.lower() for i in result['modified_ingredients']]
    assert 'chicken' not in ing_names
    assert 'parmesan' not in ing_names

def test_allergen_removal():
    """Test allergen filtering"""
    recipe = Recipe(
        id="1",
        name="Test",
        ingredients=[
            Ingredient("peanuts", "100", "g", ["nuts"]),
            Ingredient("pasta", "300", "g", ["grain"])
        ],
        instructions=["Cook"],
        cuisine="Test",
        dietary_tags=[]
    )
    
    preferences = UserPreference(
        user_id="test",
        dietary_type="non-veg",
        allergens=["nuts"],
        blocked_ingredients=[],
        flavor_preferences={}
    )
    
    customizer = CustomizeRecipe()
    result = customizer.execute(recipe, preferences)
    
    ing_names = [i.name.lower() for i in result['modified_ingredients']]
    assert 'peanuts' not in ing_names
