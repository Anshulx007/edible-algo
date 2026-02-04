"""API routes: generate"""
from fastapi import APIRouter

router = APIRouter()

@router.post("/")
def generate():
    return {"recipe": "generated"}
