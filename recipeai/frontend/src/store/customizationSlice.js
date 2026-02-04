import { createSlice } from '@reduxjs/toolkit'

const customizationSlice = createSlice({
  name: 'customization',
  initialState: {
    result: null,
    loading: false,
    error: null,
  },
  reducers: {
    setResult: (state, action) => {
      state.result = action.payload
    },
    setLoading: (state, action) => {
      state.loading = action.payload
    },
    setError: (state, action) => {
      state.error = action.payload
    },
  },
})

export const { setResult, setLoading, setError } = customizationSlice.actions
export default customizationSlice.reducer
