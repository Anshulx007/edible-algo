import React from 'react'
import { ArrowUpRight, Clock, Users } from 'lucide-react'

export default function RecipeCard({ recipe, onClick }) {
  return (
    <div
      onClick={onClick}
      className="card cursor-pointer group"
    >
      <div className="flex items-start justify-between mb-4">
        <div>
          <h3 className="text-xl font-bold text-slate-900">{recipe.name}</h3>
          <span className="badge mt-2 inline-flex">{recipe.cuisine}</span>
        </div>
        <div className="rounded-full border border-slate-200 p-2 text-slate-400 group-hover:text-orange-600 group-hover:border-orange-200 transition-all">
          <ArrowUpRight className="w-4 h-4" />
        </div>
      </div>

      <div className="flex gap-4 text-sm text-slate-500 mb-4">
        {recipe.prepTime && (
          <div className="flex items-center gap-1">
            <Clock className="w-4 h-4" />
            {recipe.prepTime}
          </div>
        )}
        {recipe.servings && (
          <div className="flex items-center gap-1">
            <Users className="w-4 h-4" />
            {recipe.servings} servings
          </div>
        )}
      </div>
      
      <div className="flex flex-wrap gap-2 mb-4">
        {recipe.ingredients?.slice(0, 5).map((ing, idx) => (
          <span key={idx} className="chip">
            {ing}
          </span>
        ))}
        {recipe.ingredients?.length > 5 && (
          <span className="text-xs text-slate-400">
            +{recipe.ingredients.length - 5} more
          </span>
        )}
      </div>
      
      {recipe.dietary_tags?.length > 0 && (
        <div className="flex flex-wrap gap-2">
          {recipe.dietary_tags.map((tag, idx) => (
            <span key={idx} className="tag-pill">
              {tag}
            </span>
          ))}
        </div>
      )}
    </div>
  )
}
