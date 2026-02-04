import React from 'react'

export default function RecipePreview({ recipe }) {
  if (!recipe) {
    return (
      <div className="glass-panel text-center">
        <h3 className="text-xl font-bold text-slate-900 mb-2">Pick a recipe</h3>
        <p className="text-slate-500">
          Start in Search to choose a base recipe for customization.
        </p>
      </div>
    )
  }
  
  return (
    <div className="card">
      <span className="badge mb-4 inline-flex">Original</span>
      <h2 className="text-2xl font-bold mb-2">{recipe.name}</h2>
      <p className="text-sm text-slate-500 mb-4">{recipe.cuisine}</p>
      
      <div className="mb-4">
        <h4 className="font-semibold text-slate-700 mb-2">Ingredients</h4>
        <ul className="space-y-2 text-sm">
          {recipe.ingredients?.map((ing, idx) => (
            <li key={idx} className="flex items-center justify-between rounded-xl border border-slate-100 bg-white px-3 py-2 text-slate-700">
              {ing}
            </li>
          ))}
        </ul>
      </div>
    </div>
  )
}
