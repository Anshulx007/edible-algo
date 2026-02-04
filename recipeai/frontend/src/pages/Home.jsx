import React from 'react'
import { useNavigate } from 'react-router-dom'
import { Search, Sparkles, ChefHat } from 'lucide-react'

export default function Home() {
  const navigate = useNavigate()
  
  return (
    <div className="space-y-16">
      <section className="relative overflow-hidden rounded-3xl border border-white/60 bg-white/70 backdrop-blur-2xl px-8 py-14 md:px-12 md:py-16">
        <div className="absolute -top-20 -right-16 h-48 w-48 rounded-full bg-orange-200/40 blur-3xl" />
        <div className="absolute -bottom-20 left-10 h-52 w-52 rounded-full bg-emerald-200/40 blur-3xl" />
        <div className="relative z-10 grid gap-10 lg:grid-cols-[1.2fr_0.8fr] lg:items-center">
          <div className="space-y-6">
            <span className="badge">Personal Kitchen OS</span>
            <h1 className="text-5xl md:text-6xl font-bold text-slate-900 leading-tight">
              Design meals that match your taste, diet, and time.
            </h1>
            <p className="text-lg text-slate-600 max-w-xl">
              Search, adapt, and generate recipes with a clean visual flow. Build a
              personal recipe system that respects preferences and keeps prep simple.
            </p>
            <div className="flex flex-wrap gap-3">
              <button onClick={() => navigate('/search')} className="btn-primary">
                Start Searching
              </button>
              <button onClick={() => navigate('/customize')} className="btn-secondary">
                Customize a Recipe
              </button>
            </div>
            <div className="flex flex-wrap gap-6 text-sm text-slate-500">
              <div>
                <div className="text-2xl font-bold text-slate-900">30+</div>
                Recipes ready to filter
              </div>
              <div>
                <div className="text-2xl font-bold text-slate-900">5s</div>
                Average customization
              </div>
              <div>
                <div className="text-2xl font-bold text-slate-900">100%</div>
                Preference-aware swaps
              </div>
            </div>
          </div>
          <div className="glass-panel space-y-5">
            <div className="flex items-center justify-between">
              <div>
                <h3 className="text-xl font-bold text-slate-900">Today&apos;s Flow</h3>
                <p className="text-sm text-slate-500">Search → Customize → Cook</p>
              </div>
              <div className="rounded-2xl bg-orange-100 p-3 text-orange-600">
                <ChefHat className="w-6 h-6" />
              </div>
            </div>
            <div className="space-y-3">
              <div className="card border-amber-100 bg-amber-50/60">
                <div className="flex items-center gap-3">
                  <Search className="w-5 h-5 text-orange-600" />
                  <div>
                    <div className="font-semibold text-slate-900">Find a base recipe</div>
                    <div className="text-sm text-slate-500">Filter by cuisine, tags, name.</div>
                  </div>
                </div>
              </div>
              <div className="card border-emerald-100 bg-emerald-50/60">
                <div className="flex items-center gap-3">
                  <Sparkles className="w-5 h-5 text-emerald-600" />
                  <div>
                    <div className="font-semibold text-slate-900">Customize fast</div>
                    <div className="text-sm text-slate-500">Swap ingredients for diet and allergens.</div>
                  </div>
                </div>
              </div>
              <div className="card border-slate-100 bg-white">
                <div className="flex items-center gap-3">
                  <ChefHat className="w-5 h-5 text-slate-700" />
                  <div>
                    <div className="font-semibold text-slate-900">Cook with clarity</div>
                    <div className="text-sm text-slate-500">Simple steps and clear substitutions.</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      
      <section className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div
          onClick={() => navigate('/search')}
          className="card cursor-pointer group"
        >
          <div className="flex items-center justify-between">
            <h3 className="text-2xl font-bold text-slate-900">Search Recipes</h3>
            <div className="rounded-2xl bg-orange-100 p-3 text-orange-600">
              <Search className="w-6 h-6" />
            </div>
          </div>
          <p className="mt-3 text-slate-600">
            Find recipes that fit your style, then filter by name, cuisine, or tags.
          </p>
          <button className="mt-6 text-sm font-semibold text-orange-600">
            Browse library
          </button>
        </div>

        <div
          onClick={() => navigate('/customize')}
          className="card cursor-pointer group"
        >
          <div className="flex items-center justify-between">
            <h3 className="text-2xl font-bold text-slate-900">Customize</h3>
            <div className="rounded-2xl bg-emerald-100 p-3 text-emerald-600">
              <Sparkles className="w-6 h-6" />
            </div>
          </div>
          <p className="mt-3 text-slate-600">
            Swap ingredients for vegan, vegetarian, or allergen-friendly options.
          </p>
          <button className="mt-6 text-sm font-semibold text-emerald-700">
            Open customizer
          </button>
        </div>

        <div
          onClick={() => navigate('/generate')}
          className="card cursor-pointer group"
        >
          <div className="flex items-center justify-between">
            <h3 className="text-2xl font-bold text-slate-900">Generate</h3>
            <div className="rounded-2xl bg-slate-100 p-3 text-slate-700">
              <ChefHat className="w-6 h-6" />
            </div>
          </div>
          <p className="mt-3 text-slate-600">
            Build new recipes from what you have and the flavors you want.
          </p>
          <button className="mt-6 text-sm font-semibold text-slate-700">
            Coming up next
          </button>
        </div>
      </section>
    </div>
  )
}
