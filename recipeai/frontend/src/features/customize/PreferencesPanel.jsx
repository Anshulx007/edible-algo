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
    <div className="glass-panel">
      <h2 className="text-2xl font-bold mb-2">Preferences</h2>
      <p className="text-sm text-slate-500 mb-6">
        Set a profile, then tap customize to apply substitutions.
      </p>

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
          <label className="block text-sm font-semibold text-slate-600 mb-3">
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
