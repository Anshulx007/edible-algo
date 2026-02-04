"""Adapter: Claude LLM adapter (placeholder)"""
from ....core.ports.llm_provider import LLMProvider

class ClaudeAdapter(LLMProvider):
    def complete(self, prompt: str, **kwargs) -> str:
        return "(claude) response"
