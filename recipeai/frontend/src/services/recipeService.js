import api from './api'

export const recipeService = {
  searchRecipes: async (query = '') => {
    const response = await api.get('/api/recipes/search', {
      params: { query }
    })
    return response.data
  },
  
  getRecipe: async (id) => {
    const response = await api.get(`/api/recipes/${id}`)
    return response.data
  },
}
