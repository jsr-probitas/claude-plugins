---
paths: "**/*.probitas.ts"
---

# Probitas Assertions

ALWAYS use `expect()`, ALWAYS chain.

```typescript
// ❌ WRONG
if (res.status !== 200) throw new Error("Failed");

// ✅ CORRECT
expect(res)
  .toBeOk()
  .toHaveStatus(200)
  .toHaveJsonMatching({ id: 1 });

// Negation
expect(res).not.toHaveStatus(404);
```
