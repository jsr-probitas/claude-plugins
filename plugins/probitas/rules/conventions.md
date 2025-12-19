# Probitas Conventions

## Prerequisites

**Probitas CLI must be installed before using any `probitas` commands.**

```bash
# Homebrew (macOS/Linux)
brew tap jsr-probitas/tap
brew install probitas

# Shell installer
curl -fsSL https://raw.githubusercontent.com/jsr-probitas/cli/main/install.sh | bash

# Nix
nix run github:jsr-probitas/cli
```

## File Structure

- Scenarios: `probitas/*.probitas.ts`
- Configuration: `probitas.jsonc`

## Export

- Always `export default`
- Always call `.build()` at end

## Resources

- Use `.resource()` for auto-cleanup
- Disposal in reverse order

## Tags

```bash
probitas run -s tag:api           # Match
probitas run -s "!tag:slow"       # Exclude
probitas run -s "tag:api,!tag:slow"  # AND
```

## Import

```typescript
import { client, expect, scenario, Skip } from "jsr:@probitas/probitas";
import { faker, FakeTime, spy, stub } from "jsr:@probitas/probitas";
```
