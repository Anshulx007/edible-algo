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
      <label className="block text-sm font-semibold text-slate-600 mb-2">
        Allergens to Avoid
      </label>
      <div className="grid grid-cols-3 gap-2">
        {allergens.map(allergen => (
          <button
            key={allergen.id}
            onClick={() => toggleAllergen(allergen.id)}
            className={`p-3 border rounded-2xl text-sm transition-all ${
              selected.includes(allergen.id)
                ? 'border-rose-300 bg-rose-50 text-rose-700'
                : 'border-slate-200 hover:border-orange-200 bg-white'
            }`}
          >
            <div className="text-xl mb-1">{allergen.emoji}</div>
            <div className="font-semibold">{allergen.label}</div>
          </button>
        ))}
      </div>
    </div>
  )
}
