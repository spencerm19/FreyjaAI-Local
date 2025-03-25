#!/bin/bash
# This is an initialization script for Ollama that downloads models at startup
# It can be used as an alternative to ollama-pull-models container

set -e

# Basic checks
echo "Initializing Ollama..."
echo "Checking if Ollama is running..."

# Try to connect to Ollama
MAX_RETRIES=10
RETRY_COUNT=0
while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  if curl -s http://localhost:11434/api/version > /dev/null; then
    echo "Ollama is running!"
    break
  fi
  echo "Waiting for Ollama to start (attempt $((RETRY_COUNT+1))/$MAX_RETRIES)..."
  sleep 2
  RETRY_COUNT=$((RETRY_COUNT+1))
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
  echo "Ollama did not start in time. Exiting."
  exit 1
fi

# Try to pull models
echo "Attempting to pull models..."

# Pull models with insecure flag to avoid TLS issues
echo "Pulling mistral model..."
curl -s -X POST http://localhost:11434/api/pull -d '{"name": "mistral:latest", "insecure": true}' || echo "Failed to pull mistral, continuing anyway"

echo "Pulling embedding model..."
curl -s -X POST http://localhost:11434/api/pull -d '{"name": "nomic-embed-text", "insecure": true}' || echo "Failed to pull embedding model, continuing anyway"

echo "Pulling dolphin-mixtral:8x7b model..."
curl -s -X POST http://localhost:11434/api/pull -d '{"name": "dolphin-mixtral:8x7b", "insecure": true}' || echo "Failed to pull dolphin-mixtral, continuing anyway"

echo "Pulling mxbai-embed-large:335m model..."
curl -s -X POST http://localhost:11434/api/pull -d '{"name": "mxbai-embed-large:335m", "insecure": true}' || echo "Failed to pull mxbai-embed-large, continuing anyway"

echo "Pulling nidumai/nidum-gemma-3-4b-it-uncensored:q3_k_m model..."
curl -s -X POST http://localhost:11434/api/pull -d '{"name": "nidumai/nidum-gemma-3-4b-it-uncensored:q3_k_m", "insecure": true}' || echo "Failed to pull nidum-gemma, continuing anyway"

echo "Model initialization complete!" 