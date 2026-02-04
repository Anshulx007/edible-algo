import React, { useState, useEffect } from 'react'
import { useParams } from 'react-router-dom'
import PreferencesPanel from './PreferencesPanel'
import RecipePreview from './RecipePreview'
import ResultsPanel from './ResultsPanel'
import LoadingSpinner from '../../components/LoadingSpinner'
import { useCustomization } from '../../hooks/useCustomization'
import { recipeService } from '../../services/recipeService'

export default function CustomizeView() {
  const { id } = useParams()
  const [recipe, setRecipe] = useState(null)
  const [loading, setLoading] = useState(false)
  const [preferences, setPreferences] = useState({
    dietary_type: 'non-veg',
    allergens: [],
    blocked_ingredients: [],
    flavor_preferences: {
      spicy: 0.5,
      sweet: 0.5,
      sour: 0.5
    }
  })
  
  const { customizeRecipe, loading: customizing, result } = useCustomization()
  
  useEffect(() => {
    if (id) {
      fetchRecipe()
    }
  }, [id])
  
  const fetchRecipe = async () => {
    setLoading(true)
    try {
      const data = await recipeService.getRecipe(id)
      setRecipe(data)
    } catch (error) {
      console.error('Failed to fetch recipe:', error)
    } finally {
      setLoading(false)
    }
  }
  
  const handleCustomize = async () => {
    await customizeRecipe(id || '1', preferences)
  }
  
  if (loading) return <LoadingSpinner message="Loading recipe..." />
  
  return (
    <div className="space-y-8">
      <div>
        <h1 className="section-title">Customize Recipe</h1>
        <p className="text-muted mt-2">
          Adjust dietary preferences, allergens, and flavor intensity before applying
          substitutions.
        </p>
      </div>
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <RecipePreview recipe={recipe} />

        <PreferencesPanel
          preferences={preferences}
          onChange={setPreferences}
          onCustomize={handleCustomize}
          loading={customizing}
        />

        {customizing && <LoadingSpinner message="Customizing recipe..." />}
        {result && <ResultsPanel result={result} />}
      </div>
    </div>
  )
}
