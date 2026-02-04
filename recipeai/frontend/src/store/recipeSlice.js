import { createSlice } from '@reduxjs/toolkit'

const recipeSlice = createSlice({
  name: 'recipes',
  initialState: {
    items: [],
    selected: null,
    loading: false,
    error: null,
  },
  reducers: {
    setRecipes: (state, action) => {
      state.items = action.payload
    },
    setSelected: (state, action) => {
      state.selected = action.payload
    },
    setLoading: (state, action) => {
      state.loading = action.payload
    },
    setError: (state, action) => {
      state.error = action.payload
    },
  },
})

export const { setRecipes, setSelected, setLoading, setError } = recipeSlice.actions
export default recipeSlice.reducer
