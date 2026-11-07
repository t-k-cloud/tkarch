#!/bin/bash
# API_TOKEN env var can be set to use a fixed API token; a random one is generated if unset.

SCRIPT_PATH=$(realpath "${BASH_SOURCE[0]}")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
SCRIPT_NAME=$(basename "$SCRIPT_PATH")

YML_FILE="${SCRIPT_NAME%.sh}.yml"

export MODEL_ID=qwen3.8-27b-fp8
echo "Model ID: $MODEL_ID"

set -x
docker compose -f "${SCRIPT_DIR}/${YML_FILE}" ${1:-up}
