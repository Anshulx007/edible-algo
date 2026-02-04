"""Auth middleware (placeholder)"""
from fastapi import Request, HTTPException

async def require_auth(request: Request, call_next):
    # placeholder: validate tokens, etc.
    response = await call_next(request)
    return response
