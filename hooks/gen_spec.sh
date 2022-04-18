#!/usr/bin/env bash
# This script generates the spec.yaml used in the API Gateway config.
# Run this every time the server API changes.
# Usage (from repo root): `sh scripts/generate_spec.sh`
# Requires api-spec-converter: `npm install -g api-spec-converter)`

set -euo pipefail

poetry run python -c \
    "from main import app; print(app.openapi())" \
    > spec.json \
&&
api-spec-converter \
    --from=openapi_3 \
    --to=swagger_2 \
    --syntax=yaml \
    spec.json \
    > deploy/service/spec.yaml \
&& 
rm spec.json
