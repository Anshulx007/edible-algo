#!/bin/bash

# Create Frontend Structure Script
echo "🚀 Creating Recipe AI Frontend Structure..."

# Navigate to frontend directory
cd frontend || exit

# Create all directories
echo "📁 Creating directories..."
mkdir -p src/{components,features/{customize,flavor-view,generate,profile},services,store,hooks,utils,pages}

# ============================================================================
# CONFIGURATION FILES
# ============================================================================

echo "⚙️ Creating configuration files..."

# package.json
cat > package.json << 'EOF'
{
  "name": "recipeai-frontend",
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "lint": "eslint src --ext js,jsx"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.20.0",
    "axios": "^1.6.2",
    "@reduxjs/toolkit": "^1.9.7",
    "react-redux": "^8.1.3",
    "lucide-react": "^0.292.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.37",
    "@types/react-dom": "^18.2.15",
    "@vitejs/plugin-react": "^4.2.0",
    "autoprefixer": "^10.4.16",
    "eslint": "^8.53.0",
    "postcss": "^8.4.31",
    "tailwindcss": "^3.3.5",
    "vite": "^5.0.0"
  }
}
EOF

# vite.config.js
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8000',
        changeOrigin: true
      }
    }
  }
})
EOF

# tailwind.config.js
cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#fef2f2',
          100: '#fee2e2',
          500: '#ef4444',
          600: '#dc2626',
          700: '#b91c1c',
        }
      }
    },
  },
  plugins: [],
}
EOF

# postcss.config.js
cat > postcss.config.js << 'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# index.html
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Recipe AI - Smart Recipe Customization</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

# .env.example
cat > .env.example << 'EOF'
VITE_API_BASE_URL=http://localhost:8000
VITE_APP_NAME=Recipe AI
EOF

# .gitignore
cat > .gitignore << 'EOF'
node_modules
dist
.env
.env.local
*.log
.DS_Store
EOF

# ============================================================================
# ENTRY POINT FILES
# ============================================================================

echo "📝 Creating entry point files..."

# src/main.jsx
cat > src/main.jsx << 'EOF'
import React from 'react'
import ReactDOM from 'react-dom/client'
import { Provider } from 'react-redux'
import { BrowserRouter } from 'react-router-dom'
import App from './App.jsx'
import { store } from './store/index.js'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <Provider store={store}>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </Provider>
  </React.StrictMode>,
)
EOF

# src/index.css
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply bg-gray-50 text-gray-900;
  }
}

@layer components {
  .btn-primary {
    @apply bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg transition-colors;
  }
  
  .btn-secondary {
    @apply bg-gray-200 hover:bg-gray-300 text-gray-800 font-medium py-2 px-4 rounded-lg transition-colors;
  }
  
  .card {
    @apply bg-white rounded-lg shadow-md p-6;
  }
  
  .input-field {
    @apply w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent;
  }
}
EOF

# src/App.jsx
cat > src/App.jsx << 'EOF'
import React from 'react'
import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import Home from './pages/Home'
import Search from './pages/Search'
import Customize from './pages/Customize'
import Generate from './pages/Generate'

function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/search" element={<Search />} />
        <Route path="/customize/:id?" element={<Customize />} />
        <Route path="/generate" element={<Generate />} />
      </Routes>
    </Layout>
  )
}

export default App
EOF

# ============================================================================
# COMPONENTS
# ============================================================================

echo "🎨 Creating components..."

# src/components/Layout.jsx
cat > src/components/Layout.jsx << 'EOF'
import React from 'react'
import { Link, useLocation } from 'react-router-dom'
import { ChefHat, Search, Sparkles, User } from 'lucide-react'

export default function Layout({ children }) {
  const location = useLocation()
  
  const navItems = [
    { path: '/', label: 'Home', icon: ChefHat },
    { path: '/search', label: 'Search', icon: Search },
    { path: '/customize', label: 'Customize', icon: Sparkles },
    { path: '/generate', label: 'Generate', icon: Sparkles },
  ]
  
  return (
    <div className="min-h-screen bg-gray-50">
      <header className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <Link to="/" className="flex items-center gap-2">
              <ChefHat className="w-8 h-8 text-blue-600" />
              <h1 className="text-2xl font-bold text-gray-900">Recipe AI</h1>
            </Link>
            
            <nav className="flex gap-6">
              {navItems.map(item => {
                const Icon = item.icon
                const isActive = location.pathname === item.path
                
                return (
                  <Link
                    key={item.path}
                    to={item.path}
                    className={`flex items-center gap-2 px-3 py-2 rounded-lg transition-colors ${
                      isActive 
                        ? 'bg-blue-50 text-blue-600' 
                        : 'text-gray-600 hover:bg-gray-100'
                    }`}
                  >
                    <Icon className="w-5 h-5" />
                    {item.label}
                  </Link>
                )
              })}
            </nav>
            
            <button className="p-2 rounded-lg hover:bg-gray-100">
              <User className="w-6 h-6 text-gray-600" />
            </button>
          </div>
        </div>
      </header>
      
      <main className="max-w-7xl mx-auto px-4 py-8">
        {children}
      </main>
      
      <footer className="bg-white border-t mt-12">
        <div className="max-w-7xl mx-auto px-4 py-6 text-center text-gray-600">
          <p>Recipe AI - Smart Recipe Customization</p>
        </div>
      </footer>
    </div>
  )
}
EOF

# src/components/RecipeCard.jsx
cat > src/components/RecipeCard.jsx << 'EOF'
import React from 'react'
import { Clock, Users } from 'lucide-react'

export default function RecipeCard({ recipe, onClick }) {
  return (
    <div
      onClick={onClick}
      className="card hover:shadow-lg transition-shadow cursor-pointer"
    >
      <div className="flex justify-between items-start mb-3">
        <h3 className="text-xl font-bold text-gray-900">{recipe.name}</h3>
        <span className="text-sm bg-blue-100 text-blue-700 px-2 py-1 rounded">
          {recipe.cuisine}
        </span>
      </div>
      
      <div className="flex gap-4 text-sm text-gray-600 mb-4">
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
          <span key={idx} className="text-xs bg-gray-100 text-gray-700 px-2 py-1 rounded">
            {ing}
          </span>
        ))}
        {recipe.ingredients?.length > 5 && (
          <span className="text-xs text-gray-500">
            +{recipe.ingredients.length - 5} more
          </span>
        )}
      </div>
      
      {recipe.dietary_tags?.length > 0 && (
        <div className="flex flex-wrap gap-2">
          {recipe.dietary_tags.map((tag, idx) => (
            <span key={idx} className="text-xs bg-green-100 text-green-700 px-2 py-1 rounded">
              {tag}
            </span>
          ))}
        </div>
      )}
    </div>
  )
}
EOF

# src/components/DietarySelector.jsx
cat > src/components/DietarySelector.jsx << 'EOF'
import React from 'react'

export default function DietarySelector({ value, onChange }) {
  const options = [
    { value: 'non-veg', label: 'Non-Vegetarian', emoji: '🍗' },
    { value: 'vegetarian', label: 'Vegetarian', emoji: '🥗' },
    { value: 'vegan', label: 'Vegan', emoji: '🌱' },
    { value: 'pescatarian', label: 'Pescatarian', emoji: '🐟' },
  ]
  
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-2">
        Dietary Preference
      </label>
      <div className="grid grid-cols-2 gap-3">
        {options.map(option => (
          <button
            key={option.value}
            onClick={() => onChange(option.value)}
            className={`p-4 border-2 rounded-lg transition-all ${
              value === option.value
                ? 'border-blue-500 bg-blue-50'
                : 'border-gray-200 hover:border-gray-300'
            }`}
          >
            <div className="text-2xl mb-1">{option.emoji}</div>
            <div className="text-sm font-medium">{option.label}</div>
          </button>
        ))}
      </div>
    </div>
  )
}
EOF

# src/components/AllergenSelector.jsx
cat > src/components/AllergenSelector.jsx << 'EOF'
import React from 'react'

export default function AllergenSelector({ selected, onChange }) {
  const allergens = [
    { id: 'dairy', label: 'Dairy', emoji: '🥛' },
    { id: 'nuts', label: 'Nuts', emoji: '🥜' },
    { id: 'gluten', label: 'Gluten', emoji: '🌾' },
    { id: 'soy', label: 'Soy', emoji: '🫘' },
    { id: 'eggs', label: 'Eggs', emoji: '🥚' },
    { id: 'shellfish', label: 'Shellfish', emoji: '🦐' },
  ]
  
  const toggleAllergen = (id) => {
    if (selected.includes(id)) {
      onChange(selected.filter(a => a !== id))
    } else {
      onChange([...selected, id])
    }
  }
  
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 mb-2">
        Allergens to Avoid
      </label>
      <div className="grid grid-cols-3 gap-2">
        {allergens.map(allergen => (
          <button
            key={allergen.id}
            onClick={() => toggleAllergen(allergen.id)}
            className={`p-3 border rounded-lg text-sm transition-all ${
              selected.includes(allergen.id)
                ? 'border-red-500 bg-red-50 text-red-700'
                : 'border-gray-200 hover:border-gray-300'
            }`}
          >
            <div className="text-xl mb-1">{allergen.emoji}</div>
            <div className="font-medium">{allergen.label}</div>
          </button>
        ))}
      </div>
    </div>
  )
}
EOF

# src/components/FlavorSlider.jsx
cat > src/components/FlavorSlider.jsx << 'EOF'
import React from 'react'

export default function FlavorSlider({ label, value, onChange }) {
  return (
    <div>
      <div className="flex justify-between mb-2">
        <label className="text-sm font-medium text-gray-700">{label}</label>
        <span className="text-sm text-gray-500">{Math.round(value * 100)}%</span>
      </div>
      <input
        type="range"
        min="0"
        max="1"
        step="0.1"
        value={value}
        onChange={(e) => onChange(parseFloat(e.target.value))}
        className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-600"
      />
    </div>
  )
}
EOF

# src/components/IngredientList.jsx
cat > src/components/IngredientList.jsx << 'EOF'
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
            className={`p-3 rounded-lg border ${
              sub ? 'bg-green-50 border-green-200' : 'bg-white border-gray-200'
            }`}
          >
            <div className="flex items-start justify-between">
              <div className="flex-1">
                {sub ? (
                  <>
                    <div className="flex items-center gap-2 text-sm text-gray-500 line-through">
                      <X className="w-4 h-4 text-red-500" />
                      {ing.quantity} {ing.unit} {ing.name}
                    </div>
                    <div className="flex items-center gap-2 font-medium text-green-700 mt-1">
                      <Check className="w-4 h-4" />
                      {ing.quantity} {ing.unit} {sub.substitute}
                    </div>
                    <p className="text-xs text-gray-600 mt-1 ml-6">
                      {sub.reason}
                    </p>
                  </>
                ) : (
                  <div className="font-medium">
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
EOF

# src/components/SubstitutionCard.jsx
cat > src/components/SubstitutionCard.jsx << 'EOF'
import React from 'react'
import { ArrowRight, Info } from 'lucide-react'

export default function SubstitutionCard({ substitution }) {
  return (
    <div className="card bg-gradient-to-r from-blue-50 to-green-50 border border-blue-200">
      <div className="flex items-center gap-4">
        <div className="flex-1">
          <div className="flex items-center gap-3 mb-2">
            <span className="font-bold text-gray-700">{substitution.original}</span>
            <ArrowRight className="w-5 h-5 text-blue-500" />
            <span className="font-bold text-green-700">{substitution.substitute}</span>
          </div>
          
          <div className="flex items-start gap-2 text-sm text-gray-600">
            <Info className="w-4 h-4 mt-0.5 flex-shrink-0" />
            <p>{substitution.reason}</p>
          </div>
        </div>
        
        <div className="text-right">
          <div className="text-sm text-gray-500">Confidence</div>
          <div className="text-2xl font-bold text-blue-600">
            {Math.round(substitution.confidence * 100)}%
          </div>
        </div>
      </div>
    </div>
  )
}
EOF

# src/components/LoadingSpinner.jsx
cat > src/components/LoadingSpinner.jsx << 'EOF'
import React from 'react'
import { Loader2 } from 'lucide-react'

export default function LoadingSpinner({ message = 'Loading...' }) {
  return (
    <div className="flex flex-col items-center justify-center py-12">
      <Loader2 className="w-12 h-12 text-blue-600 animate-spin mb-4" />
      <p className="text-gray-600">{message}</p>
    </div>
  )
}
EOF

# src/components/ErrorMessage.jsx
cat > src/components/ErrorMessage.jsx << 'EOF'
import React from 'react'
import { AlertCircle } from 'lucide-react'

export default function ErrorMessage({ message }) {
  return (
    <div className="bg-red-50 border border-red-200 rounded-lg p-4 flex items-start gap-3">
      <AlertCircle className="w-5 h-5 text-red-600 flex-shrink-0 mt-0.5" />
      <div>
        <h3 className="font-medium text-red-900 mb-1">Error</h3>
        <p className="text-sm text-red-700">{message}</p>
      </div>
    </div>
  )
}
EOF

# ============================================================================
# FEATURES
# ============================================================================

echo "✨ Creating feature components..."

# src/features/customize/CustomizeView.jsx
cat > src/features/customize/CustomizeView.jsx << 'EOF'
import React, { useState, useEffect } from 'react'
import { useParams } from 'react-router-dom'
import PreferencesPanel from './PreferencesPanel'
import RecipePreview from './RecipePreview'
import ResultsPanel from './ResultsPanel'
import LoadingSpinner from '../../components/LoadingSpinner'
import { useCustomization } from '../../hooks/useCustomization'
import { recipeService } from '../../services/recipeService'

export default function CustomizeView() {
  const { id } = useParams()
  const [recipe, setRecipe] = useState(null)
  const [loading, setLoading] = useState(false)
  const [preferences, setPreferences] = useState({
    dietary_type: 'non-veg',
    allergens: [],
    blocked_ingredients: [],
    flavor_preferences: {
      spicy: 0.5,
      sweet: 0.5,
      sour: 0.5
    }
  })
  
  const { customizeRecipe, loading: customizing, result } = useCustomization()
  
  useEffect(() => {
    if (id) {
      fetchRecipe()
    }
  }, [id])
  
  const fetchRecipe = async () => {
    setLoading(true)
    try {
      const data = await recipeService.getRecipe(id)
      setRecipe(data)
    } catch (error) {
      console.error('Failed to fetch recipe:', error)
    } finally {
      setLoading(false)
    }
  }
  
  const handleCustomize = async () => {
    await customizeRecipe(id || '1', preferences)
  }
  
  if (loading) return <LoadingSpinner message="Loading recipe..." />
  
  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
      <div className="lg:col-span-1">
        <RecipePreview recipe={recipe} />
      </div>
      
      <div className="lg:col-span-1">
        <PreferencesPanel
          preferences={preferences}
          onChange={setPreferences}
          onCustomize={handleCustomize}
          loading={customizing}
        />
      </div>
      
      <div className="lg:col-span-1">
        {customizing && <LoadingSpinner message="Customizing recipe..." />}
        {result && <ResultsPanel result={result} />}
      </div>
    </div>
  )
}
EOF

# src/features/customize/RecipePreview.jsx
cat > src/features/customize/RecipePreview.jsx << 'EOF'
import React from 'react'

export default function RecipePreview({ recipe }) {
  if (!recipe) {
    return (
      <div className="card">
        <p className="text-gray-500 text-center">Select a recipe to customize</p>
      </div>
    )
  }
  
  return (
    <div className="card">
      <h2 className="text-2xl font-bold mb-4">Original Recipe</h2>
      <h3 className="text-xl font-semibold mb-2">{recipe.name}</h3>
      <p className="text-sm text-gray-600 mb-4">{recipe.cuisine}</p>
      
      <div className="mb-4">
        <h4 className="font-medium mb-2">Ingredients:</h4>
        <ul className="space-y-1 text-sm">
          {recipe.ingredients?.map((ing, idx) => (
            <li key={idx} className="text-gray-700">• {ing}</li>
          ))}
        </ul>
      </div>
    </div>
  )
}
EOF

# src/features/customize/PreferencesPanel.jsx
cat > src/features/customize/PreferencesPanel.jsx << 'EOF'
import React from 'react'
import DietarySelector from '../../components/DietarySelector'
import AllergenSelector from '../../components/AllergenSelector'
import FlavorSlider from '../../components/FlavorSlider'
import { Sparkles } from 'lucide-react'

export default function PreferencesPanel({ preferences, onChange, onCustomize, loading }) {
  const updatePreference = (key, value) => {
    onChange({ ...preferences, [key]: value })
  }
  
  const updateFlavorPreference = (flavor, value) => {
    onChange({
      ...preferences,
      flavor_preferences: {
        ...preferences.flavor_preferences,
        [flavor]: value
      }
    })
  }
  
  return (
    <div className="card">
      <h2 className="text-2xl font-bold mb-6">Customize Recipe</h2>
      
      <div className="space-y-6">
        <DietarySelector
          value={preferences.dietary_type}
          onChange={(value) => updatePreference('dietary_type', value)}
        />
        
        <AllergenSelector
          selected={preferences.allergens}
          onChange={(value) => updatePreference('allergens', value)}
        />
        
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-3">
            Flavor Preferences
          </label>
          
          <div className="space-y-4">
            <FlavorSlider
              label="Spicy 🌶️"
              value={preferences.flavor_preferences.spicy}
              onChange={(value) => updateFlavorPreference('spicy', value)}
            />
            <FlavorSlider
              label="Sweet 🍯"
              value={preferences.flavor_preferences.sweet}
              onChange={(value) => updateFlavorPreference('sweet', value)}
            />
            <FlavorSlider
              label="Sour 🍋"
              value={preferences.flavor_preferences.sour}
              onChange={(value) => updateFlavorPreference('sour', value)}
            />
          </div>
        </div>
        
        <button
          onClick={onCustomize}
          disabled={loading}
          className="w-full btn-primary flex items-center justify-center gap-2"
        >
          <Sparkles className="w-5 h-5" />
          {loading ? 'Customizing...' : 'Customize Recipe'}
        </button>
      </div>
    </div>
  )
}
EOF

# src/features/customize/ResultsPanel.jsx
cat > src/features/customize/ResultsPanel.jsx << 'EOF'
import React from 'react'
import IngredientList from '../../components/IngredientList'
import SubstitutionCard from '../../components/SubstitutionCard'
import { Download, Share2 } from 'lucide-react'

export default function ResultsPanel({ result }) {
  return (
    <div className="space-y-6">
      <div className="card">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-2xl font-bold">Customized Recipe</h2>
          <div className="flex gap-2">
            <button className="p-2 hover:bg-gray-100 rounded-lg">
              <Share2 className="w-5 h-5 text-gray-600" />
            </button>
            <button className="p-2 hover:bg-gray-100 rounded-lg">
              <Download className="w-5 h-5 text-gray-600" />
            </button>
          </div>
        </div>
        
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
          <p className="text-sm text-blue-800">
            {result.summary}
          </p>
        </div>
        
        {result.substitutions?.length > 0 && (
          <div className="mb-6">
            <h3 className="font-bold mb-3">Substitutions Made</h3>
            <div className="space-y-3">
              {result.substitutions.map((sub, idx) => (
                <SubstitutionCard key={idx} substitution={sub} />
              ))}
            </div>
          </div>
        )}
        
        <div className="mb-6">
          <h3 className="font-bold mb-3">Ingredients</h3>
          <IngredientList
            ingredients={result.modified_recipe.ingredients}
            substitutions={result.substitutions}
          />
        </div>
        
        <div>
          <h3 className="font-bold mb-3">Instructions</h3>
          <ol className="space-y-2">
            {result.modified_recipe.instructions.map((step, idx) => (
              <li key={idx} className="flex gap-3">
                <span className="flex-shrink-0 w-6 h-6 bg-blue-600 text-white rounded-full flex items-center justify-center text-sm font-bold">
                  {idx + 1}
                </span>
                <span className="text-gray-700 pt-0.5">{step}</span>
              </li>
            ))}
          </ol>
        </div>
      </div>
    </div>
  )
}
EOF

# Create placeholder files for other features
touch src/features/flavor-view/FlavorAnalysis.jsx
touch src/features/generate/GenerateView.jsx
touch src/features/profile/ProfileView.jsx

# ============================================================================
# SERVICES
# ============================================================================

echo "🔧 Creating services..."

# src/services/api.js
cat > src/services/api.js << 'EOF'
import axios from 'axios'

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000'

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
})

api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

api.interceptors.response.use(
  (response) => response,
  (error) => {
    console.error('API Error:', error.response?.data || error.message)
    return Promise.reject(error)
  }
)

export default api
EOF

# src/services/recipeService.js
cat > src/services/recipeService.js << 'EOF'
import api from './api'

export const recipeService = {
  searchRecipes: async (query = '') => {
    const response = await api.get('/api/recipes/search', {
      params: { query }
    })
    return response.data
  },
  
  getRecipe: async (id) => {
    const response = await api.get(`/api/recipes/${id}`)
    return response.data
  },
}
EOF

# src/services/customizationService.js
cat > src/services/customizationService.js << 'EOF'
import api from './api'

export const customizationService = {
  customizeRecipe: async (recipeId, preferences) => {
    const response = await api.post('/api/customize/', {
      recipe_id: recipeId,
      ...preferences
    })
    return response.data
  },
}
EOF

# src/services/storageService.js
cat > src/services/storageService.js << 'EOF'
export const storageService = {
  set: (key, value) => {
    try {
      localStorage.setItem(key, JSON.stringify(value))
    } catch (error) {
      console.error('Storage error:', error)
    }
  },
  
  get: (key) => {
    try {
      const item = localStorage.getItem(key)
      return item ? JSON.parse(item) : null
    } catch (error) {
      console.error('Storage error:', error)
      return null
    }
  },
  
  remove: (key) => {
    try {
      localStorage.removeItem(key)
    } catch (error) {
      console.error('Storage error:', error)
    }
  }
}
EOF

# ============================================================================
# STORE (Redux)
# ============================================================================

echo "🗄️ Creating store..."

# src/store/index.js
cat > src/store/index.js << 'EOF'
import { configureStore } from '@reduxjs/toolkit'
import recipeReducer from './recipeSlice'
import userReducer from './userSlice'
import customizationReducer from './customizationSlice'

export const store = configureStore({
  reducer: {
    recipes: recipeReducer,
    user: userReducer,
    customization: customizationReducer,
  },
})
EOF

# src/store/recipeSlice.js
cat > src/store/recipeSlice.js << 'EOF'
import { createSlice } from '@reduxjs/toolkit'

const recipeSlice = createSlice({
  name: 'recipes',
  initialState: {
    items: [],
    selected: null,
    loading: false,
    error: null,
  },
  reducers: {
    setRecipes: (state, action) => {
      state.items = action.payload
    },
    setSelected: (state, action) => {
      state.selected = action.payload
    },
    setLoading: (state, action) => {
      state.loading = action.payload
    },
    setError: (state, action) => {
      state.error = action.payload
    },
  },
})

export const { setRecipes, setSelected, setLoading, setError } = recipeSlice.actions
export default recipeSlice.reducer
EOF

# src/store/userSlice.js
cat > src/store/userSlice.js << 'EOF'
import { createSlice } from '@reduxjs/toolkit'

const userSlice = createSlice({
  name: 'user',
  initialState: {
    profile: null,
    preferences: {
      dietary_type: 'non-veg',
      allergens: [],
    },
  },
  reducers: {
    setProfile: (state, action) => {
      state.profile = action.payload
    },
    setPreferences: (state, action) => {
      state.preferences = action.payload
    },
  },
})

export const { setProfile, setPreferences } = userSlice.actions
export default userSlice.reducer
EOF

# src/store/customizationSlice.js
cat > src/store/customizationSlice.js << 'EOF'
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
EOF

# ============================================================================
# HOOKS
# ============================================================================

echo "🎣 Creating hooks..."

# src/hooks/useCustomization.js
cat > src/hooks/useCustomization.js << 'EOF'
import { useState } from 'react'
import { customizationService } from '../services/customizationService'

export function useCustomization() {
  const [loading, setLoading] = useState(false)
  const [result, setResult] = useState(null)
  const [error, setError] = useState(null)
  
  const customizeRecipe = async (recipeId, preferences) => {
    setLoading(true)
    setError(null)
    
    try {
      const data = await customizationService.customizeRecipe(recipeId, preferences)
      setResult(data)
      return data
    } catch (err) {
      setError(err.message)
      throw err
    } finally {
      setLoading(false)
    }
  }
  
  return {
    customizeRecipe,
    loading,
    result,
    error
  }
}
EOF

# src/hooks/useRecipes.js
cat > src/hooks/useRecipes.js << 'EOF'
import { useState, useEffect } from 'react'
import { recipeService } from '../services/recipeService'

export function useRecipes(query = '') {
  const [recipes, setRecipes] = useState([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)
  
  const searchRecipes = async (searchQuery) => {
    setLoading(true)
    setError(null)
    
    try {
      const data = await recipeService.searchRecipes(searchQuery)
      setRecipes(data.recipes)
      return data.recipes
    } catch (err) {
      setError(err.message)
      throw err
    } finally {
      setLoading(false)
    }
  }
  
  useEffect(() => {
    if (query) {
      searchRecipes(query)
    }
  }, [query])
  
  return {
    recipes,
    searchRecipes,
    loading,
    error
  }
}
EOF

# src/hooks/useLocalStorage.js
cat > src/hooks/useLocalStorage.js << 'EOF'
import { useState, useEffect } from 'react'

export function useLocalStorage(key, initialValue) {
  const [storedValue, setStoredValue] = useState(() => {
    try {
      const item = window.localStorage.getItem(key)
      return item ? JSON.parse(item) : initialValue
    } catch (error) {
      console.error(error)
      return initialValue
    }
  })
  
  const setValue = (value) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value
      setStoredValue(valueToStore)
      window.localStorage.setItem(key, JSON.stringify(valueToStore))
    } catch (error) {
      console.error(error)
    }
  }
  
  return [storedValue, setValue]
}
EOF

# ============================================================================
# PAGES
# ============================================================================

echo "📄 Creating pages..."

# src/pages/Home.jsx
cat > src/pages/Home.jsx << 'EOF'
import React from 'react'
import { useNavigate } from 'react-router-dom'
import { Search, Sparkles, ChefHat } from 'lucide-react'

export default function Home() {
  const navigate = useNavigate()
  
  return (
    <div className="text-center">
      <div className="mb-12">
        <h1 className="text-5xl font-bold text-gray-900 mb-4">
          Welcome to Recipe AI
        </h1>
        <p className="text-xl text-gray-600">
          Smart recipe customization powered by AI
        </p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-4xl mx-auto">
        <div 
          onClick={() => navigate('/search')}
          className="card hover:shadow-xl transition-shadow cursor-pointer"
        >
          <Search className="w-12 h-12 text-blue-600 mx-auto mb-4" />
          <h3 className="text-xl font-bold mb-2">Search Recipes</h3>
          <p className="text-gray-600">
            Find recipes from our database
          </p>
        </div>
        
        <div 
          onClick={() => navigate('/customize')}
          className="card hover:shadow-xl transition-shadow cursor-pointer"
        >
          <Sparkles className="w-12 h-12 text-green-600 mx-auto mb-4" />
          <h3 className="text-xl font-bold mb-2">Customize</h3>
          <p className="text-gray-600">
            Adapt recipes to your dietary needs
          </p>
        </div>
        
        <div 
          onClick={() => navigate('/generate')}
          className="card hover:shadow-xl transition-shadow cursor-pointer"
        >
          <ChefHat className="w-12 h-12 text-purple-600 mx-auto mb-4" />
          <h3 className="text-xl font-bold mb-2">Generate</h3>
          <p className="text-gray-600">
            Create new recipes with AI
          </p>
        </div>
      </div>
    </div>
  )
}
EOF

# src/pages/Search.jsx
cat > src/pages/Search.jsx << 'EOF'
import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Search as SearchIcon } from 'lucide-react'
import RecipeCard from '../components/RecipeCard'
import LoadingSpinner from '../components/LoadingSpinner'
import { useRecipes } from '../hooks/useRecipes'

export default function Search() {
  const [query, setQuery] = useState('')
  const { recipes, searchRecipes, loading } = useRecipes()
  const navigate = useNavigate()
  
  const handleSearch = (e) => {
    e.preventDefault()
    searchRecipes(query)
  }
  
  return (
    <div>
      <h1 className="text-3xl font-bold mb-6">Search Recipes</h1>
      
      <form onSubmit={handleSearch} className="mb-8">
        <div className="flex gap-3">
          <input
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            placeholder="Search for recipes..."
            className="input-field flex-1"
          />
          <button type="submit" className="btn-primary flex items-center gap-2">
            <SearchIcon className="w-5 h-5" />
            Search
          </button>
        </div>
      </form>
      
      {loading && <LoadingSpinner message="Searching recipes..." />}
      
      {!loading && recipes.length > 0 && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {recipes.map(recipe => (
            <RecipeCard
              key={recipe.id}
              recipe={recipe}
              onClick={() => navigate(`/customize/${recipe.id}`)}
            />
          ))}
        </div>
      )}
      
      {!loading && recipes.length === 0 && query && (
        <div className="text-center py-12 text-gray-500">
          No recipes found. Try a different search term.
        </div>
      )}
    </div>
  )
}
EOF

# src/pages/Customize.jsx
cat > src/pages/Customize.jsx << 'EOF'
import React from 'react'
import CustomizeView from '../features/customize/CustomizeView'

export default function Customize() {
  return <CustomizeView />
}
EOF

# src/pages/Generate.jsx
cat > src/pages/Generate.jsx << 'EOF'
import React from 'react'

export default function Generate() {
  return (
    <div className="card">
      <h1 className="text-3xl font-bold mb-4">Generate Recipe</h1>
      <p className="text-gray-600">Coming soon...</p>
    </div>
  )
}
EOF

# ============================================================================
# UTILS
# ============================================================================

echo "🛠️ Creating utils..."

# src/utils/constants.js
cat > src/utils/constants.js << 'EOF'
export const DIETARY_TYPES = {
  NON_VEG: 'non-veg',
  VEGETARIAN: 'vegetarian',
  VEGAN: 'vegan',
  PESCATARIAN: 'pescatarian',
}

export const ALLERGENS = [
  'dairy',
  'nuts',
  'gluten',
  'soy',
  'eggs',
  'shellfish',
]

export const FLAVOR_TYPES = {
  SPICY: 'spicy',
  SWEET: 'sweet',
  SOUR: 'sour',
  BITTER: 'bitter',
  UMAMI: 'umami',
}
EOF

# src/utils/helpers.js
cat > src/utils/helpers.js << 'EOF'
export const capitalize = (str) => {
  return str.charAt(0).toUpperCase() + str.slice(1)
}

export const formatDate = (date) => {
  return new Date(date).toLocaleDateString()
}

export const debounce = (func, wait) => {
  let timeout
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout)
      func(...args)
    }
    clearTimeout(timeout)
    timeout = setTimeout(later, wait)
  }
}
EOF

echo "✅ Frontend structure created successfully!"
echo ""
echo "Next steps:"
echo "1. cd frontend"
echo "2. npm install"
echo "3. npm run dev"
echo ""
echo "Your frontend will be running on http://localhost:3000"
EOF

# Make script executable
chmod +x create_frontend.sh

echo "✅ Script created: create_frontend.sh"
echo ""
echo "Run it with:"
echo "  bash create_frontend.sh"