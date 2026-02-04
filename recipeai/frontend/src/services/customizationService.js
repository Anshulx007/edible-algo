import api from './api'

export const customizationService = {
  customizeRecipe: async (recipeId, preferences) => {
    const response = await api.post('/api/customize/', {
      recipe_id: recipeId,
      ...preferences
    })
    return response.data
  },
}
