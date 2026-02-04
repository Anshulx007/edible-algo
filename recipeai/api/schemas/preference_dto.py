"""API Schema: Preference DTO"""
from pydantic import BaseModel
from typing import List

class PreferenceDTO(BaseModel):
    dislikes: List[str] = []
    likes: List[str] = []
    dietary_constraints: List[str] = []
