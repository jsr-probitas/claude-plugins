# Probitas Plugin for Claude Code

Integration plugin for [Probitas](https://jsr-probitas.github.io/documents/)
scenario testing framework.

## Features

### Rules

Applied automatically when editing `*.probitas.ts` files:

- **import** - Import statements
- **pattern** - Export pattern (single/multiple)
- **assertions** - expect() chaining rules
- **mistakes** - Common mistakes to avoid
- **best-practices** - Best practices
- **context** - Step context (ctx) usage

### Skills

- **probitas-setup** - CLI installation and project setup
- **probitas-write** - Scenario writing (delegates to agent)
- **probitas-run** - Running and debugging scenarios

### Commands

| Command                    | Description                   |
| -------------------------- | ----------------------------- |
| `/probitas:init`           | Initialize a Probitas project |
| `/probitas:run [selector]` | Run scenarios                 |
| `/probitas:new <type>`     | Generate scenario template    |
| `/probitas:check`          | Run format, lint, type check  |

### Agents

- **scenario-writer** - Create and edit `*.probitas.ts` files

## Installation

```bash
# Add marketplace
/plugin marketplace add jsr-probitas/claude-plugins

# Install plugin
/plugin install probitas@jsr-probitas
```

## Team Setup

Add to your project's `.claude/settings.json`:

```json
{
  "plugins": {
    "marketplaces": ["jsr-probitas/claude-plugins"],
    "installed": ["probitas@jsr-probitas"]
  },
  "enabledPlugins": {
    "probitas@jsr-probitas": true
  }
}
```
