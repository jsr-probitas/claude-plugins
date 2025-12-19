# Probitas Conventions

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
