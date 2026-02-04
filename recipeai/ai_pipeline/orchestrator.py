"""Orchestrator: runs the pipeline end-to-end"""
from .stages import enrichment, intent_parser

class Orchestrator:
    def run(self, user_input: str):
        intent = intent_parser.parse_intent(user_input)
        enriched = enrichment.enrich(intent)
        return enriched
