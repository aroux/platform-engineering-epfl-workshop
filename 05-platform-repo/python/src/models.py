"""Pydantic data models for the provisioning YAML configuration."""

from __future__ import annotations

import re

from pydantic import BaseModel, model_validator

class Group(BaseModel):
    name: str


class ProvisioningConfig(BaseModel):
    groups: list[Group]

