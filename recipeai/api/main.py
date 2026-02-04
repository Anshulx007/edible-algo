from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from recipeai.api.routes import customize, recipes

app = FastAPI(
    title="Recipe AI API",
    description="MVP: Recipe customization with dietary substitution",
    version="0.1.0"
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure properly for production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routes
app.include_router(customize.router)
app.include_router(recipes.router)

@app.get("/")
async def root():
    return {
        "message": "Recipe AI MVP",
        "version": "0.1.0",
        "endpoints": ["/api/recipes", "/api/customize"]
    }

@app.get("/health")
async def health():
    return {"status": "healthy"}
