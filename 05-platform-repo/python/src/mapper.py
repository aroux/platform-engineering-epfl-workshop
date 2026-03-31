"""Mapper – transforms validated Pydantic config into a flat tfvars structure."""

from __future__ import annotations

from .models import ProvisioningConfig

_PERMISSION_LEVELS = {
    "admin": "admin",
    "write": "push",
}


def build_tfvars(config: ProvisioningConfig) -> dict:
    return {}