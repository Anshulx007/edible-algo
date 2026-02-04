import React from 'react'
export default function LoadingSpinner({ message = 'Loading...' }) {
  return (
    <div className="glass-panel">
      <div className="flex items-center justify-between mb-6">
        <div>
          <div className="text-sm uppercase tracking-wide text-slate-500">
            In Progress
          </div>
          <div className="text-xl font-bold text-slate-900">{message}</div>
        </div>
        <div className="h-10 w-10 rounded-full bg-orange-100 animate-pulse" />
      </div>
      <div className="space-y-3">
        <div className="h-4 w-full skeleton" />
        <div className="h-4 w-5/6 skeleton" />
        <div className="h-4 w-2/3 skeleton" />
      </div>
    </div>
  )
}
