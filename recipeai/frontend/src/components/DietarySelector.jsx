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
      <label className="block text-sm font-semibold text-slate-600 mb-2">
        Dietary Preference
      </label>
      <div className="grid grid-cols-2 gap-3">
        {options.map(option => (
          <button
            key={option.value}
            onClick={() => onChange(option.value)}
            className={`p-4 border rounded-2xl transition-all ${
              value === option.value
                ? 'border-orange-300 bg-orange-50 text-orange-700'
                : 'border-slate-200 hover:border-orange-200 bg-white'
            }`}
          >
            <div className="text-2xl mb-1">{option.emoji}</div>
            <div className="text-sm font-semibold">{option.label}</div>
          </button>
        ))}
      </div>
    </div>
  )
}
