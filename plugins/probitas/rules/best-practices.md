---
paths: "**/*.probitas.ts"
---

# Probitas Best Practices

- Descriptive step names ("Create user" not "Step 1")
- Return data for `ctx.previous`
- Use tags for filtering (`{ tags: ["api", "slow"] }`)
- One responsibility per step
- Use `.setup()` with cleanup for fixtures
- Register clients as `.resource()` for auto-cleanup
- Use `toHaveJsonMatching()` / `toHaveDataMatching()` for partial matching
