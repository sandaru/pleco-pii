#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
command -v ollama >/dev/null || { echo "Install Ollama first: https://ollama.com/download"; exit 1; }
expected=$(python3 -c "import json;print(json.load(open('manifest.json'))['files']['pleco-pii.gguf']['sha256'])")
actual=$(sha256sum pleco-pii.gguf | cut -d' ' -f1)
[ "$expected" = "$actual" ] || { echo "pleco-pii.gguf checksum mismatch"; exit 1; }
ollama create pleco-pii -f Modelfile
ollama list
