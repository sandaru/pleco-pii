$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) { throw "Install Ollama first: https://ollama.com/download" }
$expected = (Get-Content manifest.json | ConvertFrom-Json).files."pleco-pii.gguf".sha256
$actual = (Get-FileHash pleco-pii.gguf -Algorithm SHA256).Hash.ToLower()
if ($actual -ne $expected) { throw "pleco-pii.gguf checksum mismatch" }
ollama create pleco-pii -f Modelfile
ollama list
