---
name: probitas-setup
description: Probitas project setup and installation. Use when initializing Probitas, setting up E2E testing, or installing probitas CLI.
---

## CRITICAL: USE SLASH COMMANDS

**NEVER run `probitas init` directly.**

You MUST use the `/probitas-init` slash command:

```
SlashCommand tool: command="/probitas-init"
```

The slash command handles directory setup and configuration correctly.

## Workflow

1. **Execute `/probitas-init`** via SlashCommand tool
2. Report created files to user

## CLI Installation (only if CLI not found)

```bash
# Shell installer
curl -fsSL https://raw.githubusercontent.com/jsr-probitas/cli/main/install.sh | bash

# Homebrew (macOS/Linux)
brew tap jsr-probitas/tap && brew install probitas

# Nix (run directly)
nix run github:jsr-probitas/cli
```

Verify: `probitas --version`

## Created Files

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
