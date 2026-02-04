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
