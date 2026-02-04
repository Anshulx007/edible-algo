import React from 'react'
import { ArrowRight, Info } from 'lucide-react'

export default function SubstitutionCard({ substitution }) {
  return (
    <div className="card bg-gradient-to-r from-orange-50 to-emerald-50 border border-orange-200">
      <div className="flex items-center gap-4">
        <div className="flex-1">
          <div className="flex items-center gap-3 mb-2">
            <span className="font-bold text-slate-700">{substitution.original}</span>
            <ArrowRight className="w-5 h-5 text-orange-500" />
            <span className="font-bold text-emerald-700">{substitution.substitute}</span>
          </div>
          
          <div className="flex items-start gap-2 text-sm text-slate-600">
            <Info className="w-4 h-4 mt-0.5 flex-shrink-0" />
            <p>{substitution.reason}</p>
          </div>
        </div>
        
        <div className="text-right">
          <div className="text-sm text-slate-500">Confidence</div>
          <div className="text-2xl font-bold text-orange-600">
            {Math.round(substitution.confidence * 100)}%
          </div>
        </div>
      </div>
    </div>
  )
}
