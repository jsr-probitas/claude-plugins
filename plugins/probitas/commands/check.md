---
description: Run format, lint, and type check for scenarios
---

## Workflow

1. **Format** - Run `deno fmt`
2. **Lint** - Run `deno lint`
3. **Check** - Run `deno check`
4. **Fix** - If issues found, fix them and repeat

```bash
deno fmt probitas/
deno lint --rules-exclude=no-import-prefix,no-unversioned-import probitas/
deno check probitas/**/*.probitas.ts
```

Fix issues iteratively until all pass.
