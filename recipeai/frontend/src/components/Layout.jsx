import React from 'react'
import { Link, useLocation } from 'react-router-dom'
import { ChefHat, Search, Sparkles, User, Wand2 } from 'lucide-react'

export default function Layout({ children }) {
  const location = useLocation()
  
  const navItems = [
    { path: '/', label: 'Home', icon: ChefHat },
    { path: '/search', label: 'Search', icon: Search },
    { path: '/customize', label: 'Customize', icon: Sparkles },
    { path: '/generate', label: 'Generate', icon: Sparkles },
  ]
  
  return (
    <div className="page-shell">
      <header className="sticky top-0 z-30 backdrop-blur-xl bg-white/80 border-b border-white/60">
        <div className="max-w-7xl mx-auto px-4 py-4">
          <div className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
            <Link to="/" className="flex items-center gap-3">
              <span className="p-2 rounded-2xl bg-orange-100 text-orange-600 shadow-sm">
                <ChefHat className="w-7 h-7" />
              </span>
              <div>
                <h1 className="text-2xl font-bold text-slate-900">Recipe AI</h1>
                <p className="text-sm text-slate-500">Cooking with intent</p>
              </div>
            </Link>

            <nav className="flex flex-wrap gap-3">
              {navItems.map(item => {
                const Icon = item.icon
                const isActive = location.pathname === item.path
                
                return (
                  <Link
                    key={item.path}
                    to={item.path}
                    className={`flex items-center gap-2 px-4 py-2 rounded-full text-sm font-semibold transition-all border ${
                      isActive 
                        ? 'bg-white border-orange-200 text-orange-700 shadow-sm' 
                        : 'bg-white/60 border-transparent text-slate-600 hover:bg-white hover:border-orange-100'
                    }`}
                  >
                    <Icon className="w-4 h-4" />
                    {item.label}
                  </Link>
                )
              })}
            </nav>

            <div className="flex items-center gap-3">
              <button className="btn-secondary flex items-center gap-2">
                <Wand2 className="w-4 h-4" />
                Quick Generate
              </button>
              <button className="p-2 rounded-xl bg-white border border-amber-100 hover:border-amber-200">
                <User className="w-5 h-5 text-slate-600" />
              </button>
            </div>
          </div>
        </div>
      </header>
      
      <main className="max-w-7xl mx-auto px-4 py-10">
        {children}
      </main>
      
      <footer className="mt-16">
        <div className="max-w-7xl mx-auto px-4 py-10">
          <div className="glass-panel flex flex-col md:flex-row md:items-center md:justify-between gap-6">
            <div>
              <h3 className="text-2xl font-bold text-slate-900">Recipe AI Studio</h3>
              <p className="text-muted">
                Smart recipe customization with clean ingredients and clear intent.
              </p>
            </div>
            <div className="flex gap-3">
              <button className="btn-secondary">Explore Recipes</button>
              <button className="btn-primary">Start Customizing</button>
            </div>
          </div>
        </div>
      </footer>
    </div>
  )
}
