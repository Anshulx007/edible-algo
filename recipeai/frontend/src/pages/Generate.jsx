import React from 'react'

export default function Generate() {
  return (
    <div className="grid gap-8 lg:grid-cols-[1.1fr_0.9fr]">
      <div className="glass-panel space-y-4">
        <span className="badge">AI Studio</span>
        <h1 className="section-title">Generate a new recipe</h1>
        <p className="text-muted">
          Tell us what you have, the mood, and how much time you want to spend.
          We&apos;ll build a recipe that fits your pantry and preferences.
        </p>
        <div className="grid gap-4 md:grid-cols-2">
          <div>
            <label className="text-sm font-semibold text-slate-600">Main ingredient</label>
            <input className="input-field mt-2" placeholder="e.g., chickpeas" />
          </div>
          <div>
            <label className="text-sm font-semibold text-slate-600">Cuisine</label>
            <input className="input-field mt-2" placeholder="e.g., Mediterranean" />
          </div>
          <div>
            <label className="text-sm font-semibold text-slate-600">Diet</label>
            <input className="input-field mt-2" placeholder="e.g., vegan" />
          </div>
          <div>
            <label className="text-sm font-semibold text-slate-600">Time</label>
            <input className="input-field mt-2" placeholder="e.g., 25 minutes" />
          </div>
        </div>
        <button className="btn-primary w-full">Generate Recipe</button>
      </div>

      <div className="card space-y-4">
        <h2 className="text-2xl font-bold text-slate-900">What you&apos;ll get</h2>
        <ul className="space-y-3 text-slate-600">
          <li>Ingredient list tuned to your diet and allergens.</li>
          <li>Steps that respect your preferred cooking time.</li>
          <li>Optional swaps for spicy, sweet, or sour cravings.</li>
        </ul>
        <div className="rounded-2xl border border-dashed border-slate-200 p-6 text-center text-slate-500">
          Live generation is coming next. For now, use Search and Customize.
        </div>
      </div>
    </div>
  )
}
