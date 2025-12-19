---
name: probitas-run
description: Running and validating Probitas scenarios. Use when executing tests, running scenarios, or debugging test failures.
---

## Instructions

When this skill is triggered:

1. If project not initialized (no `probitas.jsonc` or `*.probitas.ts`) → trigger `probitas-setup` skill first
2. **Execute `/probitas-run`** to run scenarios (or `/probitas-run <selector>` with filter)
3. If tests fail, analyze error messages and suggest fixes

## Selector Examples

```bash
probitas run -s tag:api             # Match tag
probitas run -s "!tag:slow"         # Exclude tag
probitas run -s "tag:api,!tag:slow" # AND condition
probitas run -s user                # Match scenario name
```

## Validate Before Running

**Execute `/probitas-check`** for full validation (format, lint, type check).

Or manually:

```bash
deno check **/*.probitas.ts
```

## Debugging Failures

```bash
probitas run --verbose  # Detailed output
probitas run --debug    # Debug mode
```

1. Check error message for assertion details
2. Use `.toHaveJsonMatching()` / `.toHaveDataMatching()` with partial object
3. Verify environment variables (API_URL, DATABASE_URL, etc.)

## Docs

Fetch via WebFetch: https://jsr-probitas.github.io/documents/docs/scenario/index.md
