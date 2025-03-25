# Shared Directory

This directory is mounted in the n8n container for sharing files between services.

Use this directory to store:
- Files for processing in workflows
- Scripts to be executed by n8n
- Shared resources between containers

## Directory Structure

You can organize this directory as needed, for example:

```
shared/
  scripts/       # Python or bash scripts
  data/          # Data files (CSV, JSON, etc.)
  templates/     # Templates for document generation
  output/        # Output files from workflows
```

## Usage in n8n

In n8n workflows, this directory is available at `/data/shared`.

Example of accessing a file in a Python script node:
```python
with open('/data/shared/data/example.json', 'r') as f:
    data = json.load(f)
```
