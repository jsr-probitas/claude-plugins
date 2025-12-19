---
paths: "**/*.probitas.ts"
---

# Probitas Step Context

Available in `.resource()`, `.setup()`, and `.step()`:

- `ctx.previous` - Previous step's return value
- `ctx.results` - All previous step results (tuple)
- `ctx.resources` - Registered resources by name
- `ctx.store` - Shared Map across steps
- `ctx.signal` - AbortSignal for cancelable operations
