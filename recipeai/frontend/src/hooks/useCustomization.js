import { useState } from 'react'
import { customizationService } from '../services/customizationService'

export function useCustomization() {
  const [loading, setLoading] = useState(false)
  const [result, setResult] = useState(null)
  const [error, setError] = useState(null)
  
  const customizeRecipe = async (recipeId, preferences) => {
    setLoading(true)
    setError(null)
    
    try {
      const data = await customizationService.customizeRecipe(recipeId, preferences)
      setResult(data)
      return data
    } catch (err) {
      setError(err.message)
      throw err
    } finally {
      setLoading(false)
    }
  }
  
  return {
    customizeRecipe,
    loading,
    result,
    error
  }
}
