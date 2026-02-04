"""API Schema: Response DTO"""
from pydantic import BaseModel

class ResponseDTO(BaseModel):
    status: str
    message: str | None = None
