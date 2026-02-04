import React from 'react'

export default function FlavorSlider({ label, value, onChange }) {
  return (
    <div>
      <div className="flex justify-between mb-2">
        <label className="text-sm font-semibold text-slate-700">{label}</label>
        <span className="text-sm text-slate-500">{Math.round(value * 100)}%</span>
      </div>
      <input
        type="range"
        min="0"
        max="1"
        step="0.1"
        value={value}
        onChange={(e) => onChange(parseFloat(e.target.value))}
        className="w-full h-2 bg-orange-100 rounded-lg appearance-none cursor-pointer accent-orange-500"
      />
    </div>
  )
}
