import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Search as SearchIcon, X } from 'lucide-react'
import RecipeCard from '../components/RecipeCard'
import LoadingSpinner from '../components/LoadingSpinner'
import { useRecipes } from '../hooks/useRecipes'

export default function Search() {
  const [query, setQuery] = useState('')
  const { recipes, searchRecipes, loading } = useRecipes()
  const navigate = useNavigate()
  const popularSearches = ['Burrito', 'Pasta', 'Salad', 'Soup', 'Curry', 'Tofu']
  
  const handleSearch = (e) => {
    e.preventDefault()
    searchRecipes(query)
  }

  const handleQuickSearch = (term) => {
    setQuery(term)
    searchRecipes(term)
  }
  
  return (
    <div className="space-y-10">
      <div className="flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
        <div>
          <h1 className="section-title">Search Recipes</h1>
          <p className="text-muted mt-2 max-w-xl">
            Search by name and filter fast. Try starting letters like "A" or full names
            like "Black Bean Burrito".
          </p>
        </div>
        <div className="flex flex-wrap gap-2">
          {popularSearches.map(term => (
            <button
              key={term}
              onClick={() => handleQuickSearch(term)}
              className="chip hover:border-orange-200 hover:text-orange-600"
            >
              {term}
            </button>
          ))}
        </div>
      </div>
      
      <form onSubmit={handleSearch} className="glass-panel">
        <div className="flex flex-col gap-4 md:flex-row md:items-center">
          <div className="relative flex-1">
            <SearchIcon className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400" />
            <input
              type="text"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search by recipe name..."
              className="input-field pl-12"
            />
            {query && (
              <button
                type="button"
                onClick={() => setQuery('')}
                className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
              >
                <X className="w-4 h-4" />
              </button>
            )}
          </div>
          <button type="submit" className="btn-primary flex items-center justify-center gap-2">
            <SearchIcon className="w-5 h-5" />
            Search
          </button>
        </div>
      </form>
      
      {loading && <LoadingSpinner message="Searching recipes..." />}
      
      {!loading && recipes.length > 0 && (
        <div className="space-y-4">
          <div className="flex items-center justify-between text-sm text-slate-500">
            <span>{recipes.length} recipes found</span>
            <span className="badge">Sorted by name</span>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {recipes.map(recipe => (
              <RecipeCard
                key={recipe.id}
                recipe={recipe}
                onClick={() => navigate(`/customize/${recipe.id}`)}
              />
            ))}
          </div>
        </div>
      )}
      
      {!loading && recipes.length === 0 && query && (
        <div className="glass-panel text-center py-12">
          <h3 className="text-2xl font-bold text-slate-900 mb-3">No recipes found</h3>
          <p className="text-muted mb-6">
            Try a shorter query, or search by the first letter.
          </p>
          <div className="flex flex-wrap justify-center gap-2">
            {popularSearches.map(term => (
              <button
                key={term}
                onClick={() => handleQuickSearch(term)}
                className="chip hover:border-orange-200 hover:text-orange-600"
              >
                {term}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
