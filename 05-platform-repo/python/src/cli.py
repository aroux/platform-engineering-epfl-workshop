"""Platform CLI – three-phase provisioning tool.

Phase 1: parse YAML config into Pydantic models, export as JSON
Phase 2: parse JSON back into models, generate a .tfvars.json file
Phase 3: (handled by bash script) terraform plan/apply
"""

from __future__ import annotations

import json
from pathlib import Path

import typer
import yaml

from .mapper import build_tfvars
from .models import ProvisioningConfig

app = typer.Typer(help="Platform provisioning CLI")


@app.command()
def yaml_to_json(
    yaml_file: Path = typer.Argument(..., help="Path to provisioning.yaml"),
    output: Path = typer.Option("provisioning.json", help="Output JSON file path"),
) -> None:
    """Phase 1: Parse YAML into Pydantic models and export as JSON."""


@app.command()
def json_to_tfvars(
    json_file: Path = typer.Argument(..., help="Path to provisioning.json"),
    output: Path = typer.Option("terraform.tfvars.json", help="Output tfvars JSON file path"),
) -> None:
    """Phase 2: Parse JSON back into Pydantic models and generate a tfvars file."""


if __name__ == "__main__":
    app()
