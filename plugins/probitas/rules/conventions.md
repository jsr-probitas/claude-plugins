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

## Import

```typescript
import { client, expect, scenario, Skip } from "jsr:@probitas/probitas";
import { faker, FakeTime, spy, stub } from "jsr:@probitas/probitas";
```
