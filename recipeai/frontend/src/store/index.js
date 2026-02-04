import { configureStore } from '@reduxjs/toolkit'
import recipeReducer from './recipeSlice'
import userReducer from './userSlice'
import customizationReducer from './customizationSlice'

export const store = configureStore({
  reducer: {
    recipes: recipeReducer,
    user: userReducer,
    customization: customizationReducer,
  },
})
