---
name: probitas-run
description: Running and validating Probitas scenarios. Use when executing tests, running scenarios, or debugging test failures.
---

## Run Scenarios

Use `/probitas:run` or:

```bash
# Run all
probitas run

# With selector
probitas run -s tag:api
probitas run -s "!tag:slow"         # Exclude
probitas run -s "tag:api,!tag:slow" # AND condition
probitas run -s user                # Match scenario name
```

## Validate Before Running

```bash
deno check **/*.probitas.ts
```

Or use `/probitas:check` for full validation (format, lint, type check).

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
