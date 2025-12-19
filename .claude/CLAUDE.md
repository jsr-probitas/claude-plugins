# Probitas Claude Plugins Marketplace

Claude Code plugin marketplace for Probitas ecosystem.

## Structure

```
claude-plugins/
├── marketplace.json      # Marketplace definition
├── plugins/
│   └── probitas/         # Probitas plugin
│       ├── .claude-plugin/
│       ├── rules/
│       ├── skills/
│       ├── commands/
│       └── agents/
└── .claude/              # This repo's Claude config
```

## Commands

```bash
# No build step - this is a pure Markdown/JSON repository
```

## Documentation Source

Plugin content is based on Probitas documentation:

- Site: https://jsr-probitas.github.io/documents/
- LLM sitemap: https://jsr-probitas.github.io/documents/llms.txt

## Updating Plugin Content

Use `/doc:update` to sync plugin content with latest Probitas documentation.
