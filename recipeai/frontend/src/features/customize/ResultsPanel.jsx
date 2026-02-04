import React from 'react'
import IngredientList from '../../components/IngredientList'
import SubstitutionCard from '../../components/SubstitutionCard'
import { Download, Share2 } from 'lucide-react'

export default function ResultsPanel({ result }) {
  return (
    <div className="space-y-6">
      <div className="card">
        <div className="flex items-center justify-between mb-4">
          <div>
            <span className="badge">Customized</span>
            <h2 className="text-2xl font-bold mt-2">Personalized Recipe</h2>
          </div>
          <div className="flex gap-2">
            <button className="p-2 hover:bg-orange-50 rounded-xl border border-transparent hover:border-orange-100">
              <Share2 className="w-5 h-5 text-slate-600" />
            </button>
            <button className="p-2 hover:bg-orange-50 rounded-xl border border-transparent hover:border-orange-100">
              <Download className="w-5 h-5 text-slate-600" />
            </button>
          </div>
        </div>

        <div className="rounded-2xl border border-orange-100 bg-orange-50/70 p-4 mb-6">
          <p className="text-sm text-orange-800">
            {result.summary}
          </p>
        </div>
        
        {result.substitutions?.length > 0 && (
          <div className="mb-6">
            <h3 className="text-lg font-bold mb-3">Substitutions Made</h3>
            <div className="space-y-3">
              {result.substitutions.map((sub, idx) => (
                <SubstitutionCard key={idx} substitution={sub} />
              ))}
            </div>
          </div>
        )}
        
        <div className="mb-6">
          <h3 className="text-lg font-bold mb-3">Ingredients</h3>
          <IngredientList
            ingredients={result.modified_recipe.ingredients}
            substitutions={result.substitutions}
          />
        </div>
        
        <div>
          <h3 className="text-lg font-bold mb-3">Instructions</h3>
          <ol className="space-y-3">
            {result.modified_recipe.instructions.map((step, idx) => (
              <li key={idx} className="flex gap-3">
                <span className="flex-shrink-0 w-7 h-7 bg-orange-500 text-white rounded-full flex items-center justify-center text-sm font-bold">
                  {idx + 1}
                </span>
                <span className="text-slate-700 pt-0.5">{step}</span>
              </li>
            ))}
          </ol>
        </div>
      </div>
    </div>
  )
}
