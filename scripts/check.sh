#!/usr/bin/env bash

set -euo pipefail

project_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$project_root"
project_python="$project_root/.venv/bin/python"

printf '\n==> Ruff formatting\n'
"$project_python" -m ruff format --check .

printf '\n==> Ruff linting\n'
"$project_python" -m ruff check .

printf '\n==> Mypy type checking\n'
"$project_python" -m mypy

printf '\n==> Dependency vulnerability audit\n'
"$project_python" -m pip_audit --strict -r requirements-dev.txt -r requirements.txt

printf '\n==> Pytest and coverage\n'
"$project_python" -m pytest -q --tb=short
