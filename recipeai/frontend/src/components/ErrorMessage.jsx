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
