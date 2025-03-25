# LocalAI Environment for Ubuntu

This repository contains all the necessary files to run LocalAI with Ollama, OpenWebUI, and additional tools on Ubuntu.

## Components

- **Ollama**: LLM inference server
- **OpenWebUI**: Web interface for interacting with models
- **N8N**: Workflow automation 
- **Flowise**: Visual AI workflow builder
- **Qdrant**: Vector database

## Pre-configured Models

The following models will be pulled automatically:
- mistral:latest
- nomic-embed-text
- dolphin-mixtral:8x7b
- mxbai-embed-large:335m
- nidumai/nidum-gemma-3-4b-it-uncensored:q3_k_m

## Requirements

- Ubuntu Desktop (tested on Ubuntu 22.04+)
- Docker and Docker Compose installed
- At least 20GB of free disk space for models
- 16GB RAM recommended

## Installation

1. Clone or download this folder to your Ubuntu machine
2. Open a terminal in the folder
3. Make the init script executable:
   ```bash
   chmod +x init-ollama.sh
   ```
4. Start the environment:
   ```bash
   docker compose up -d
   ```

## Accessing Services

- **OpenWebUI**: http://localhost:3000
- **N8N**: http://localhost:5678
- **Flowise**: http://localhost:3001
- **Qdrant**: http://localhost:6333
- **Ollama API**: http://localhost:11434

## Troubleshooting

### Certificate Issues
This setup includes environment variables and configurations to work around common TLS certificate verification issues:
- `OLLAMA_INSECURE=true`
- `OLLAMA_SKIP_CERT_VERIFY=true`
- `NODE_TLS_REJECT_UNAUTHORIZED=0`

### Model Downloading
Models are downloaded in two ways:
1. At first startup through the ollama-pull-models container
2. Inside the Ollama container itself through the start.sh script

If models fail to download, you can manually pull them:
```bash
docker exec -it ollama ollama pull mistral
```

### Resource Usage
Large models (like dolphin-mixtral:8x7b) require significant resources. If you're on a system with limited RAM, consider removing the larger models from the configuration files.

## Adding Custom Models

Edit the Modelfile in this directory to create your own custom model. Then run:
```bash
docker exec -it ollama ollama create mymodel -f /Modelfile
```

## Stopping the Environment

```bash
docker compose down
```

To completely remove all data (including downloaded models):
```bash
docker compose down -v
``` 