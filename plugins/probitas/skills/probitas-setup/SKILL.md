---
name: probitas-setup
description: Probitas project setup and installation. Use when initializing Probitas, setting up E2E testing, or installing probitas CLI.
---

## CLI Installation

```bash
# Shell installer
curl -fsSL https://raw.githubusercontent.com/jsr-probitas/cli/main/install.sh | bash

# Homebrew (macOS/Linux)
brew tap jsr-probitas/tap && brew install probitas

# Nix (run directly)
nix run github:jsr-probitas/cli

# Nix (permanent install)
nix profile install github:jsr-probitas/cli
```

Verify: `probitas --version`

## Project Initialization

Run `/probitas:init` or:

```bash
probitas init              # Default directory
probitas init -d scenarios # Custom directory
probitas init --force      # Overwrite existing
```

Creates:

- `example.probitas.ts` - Sample scenario
- `probitas.jsonc` - Configuration

## Project Structure

```
project/
├── probitas/
│   ├── example.probitas.ts
│   └── ...
└── probitas.jsonc
```

## Configuration (probitas.jsonc)

```jsonc
{
  "includes": ["probitas/**/*.probitas.ts"],
  "excludes": [],
  "timeout": "30s",
  "maxConcurrency": 0 // 0 = unlimited
}
```

## Docs

- Installation: https://jsr-probitas.github.io/documents/docs/installation/index.md
- Configuration: https://jsr-probitas.github.io/documents/docs/configuration/index.md
