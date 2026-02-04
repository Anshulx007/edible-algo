import { useState, useEffect } from 'react'
import { recipeService } from '../services/recipeService'

export function useRecipes(query = '') {
  const [recipes, setRecipes] = useState([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)
  
  const searchRecipes = async (searchQuery) => {
    setLoading(true)
    setError(null)
    
    try {
      const data = await recipeService.searchRecipes(searchQuery)
      setRecipes(data.recipes)
      return data.recipes
    } catch (err) {
      setError(err.message)
      throw err
    } finally {
      setLoading(false)
    }
  }
  
  useEffect(() => {
    if (query) {
      searchRecipes(query)
    }
  }, [query])
  
  return {
    recipes,
    searchRecipes,
    loading,
    error
  }
}
