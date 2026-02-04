import React from 'react'
import { Check, X } from 'lucide-react'

export default function IngredientList({ ingredients, substitutions = [] }) {
  const getSubstitution = (ingredientName) => {
    return substitutions.find(
      sub => sub.original.toLowerCase() === ingredientName.toLowerCase()
    )
  }
  
  return (
    <div className="space-y-2">
      {ingredients.map((ing, idx) => {
        const sub = getSubstitution(ing.name)
        
        return (
          <div
            key={idx}
            className={`p-3 rounded-2xl border ${
              sub ? 'bg-emerald-50 border-emerald-200' : 'bg-white border-slate-200'
            }`}
          >
            <div className="flex items-start justify-between">
              <div className="flex-1">
                {sub ? (
                  <>
                    <div className="flex items-center gap-2 text-sm text-slate-400 line-through">
                      <X className="w-4 h-4 text-rose-500" />
                      {ing.quantity} {ing.unit} {ing.name}
                    </div>
                    <div className="flex items-center gap-2 font-semibold text-emerald-700 mt-1">
                      <Check className="w-4 h-4" />
                      {ing.quantity} {ing.unit} {sub.substitute}
                    </div>
                    <p className="text-xs text-slate-500 mt-1 ml-6">
                      {sub.reason}
                    </p>
                  </>
                ) : (
                  <div className="font-semibold text-slate-700">
                    {ing.quantity} {ing.unit} {ing.name}
                  </div>
                )}
              </div>
            </div>
          </div>
        )
      })}
    </div>
  )
}
