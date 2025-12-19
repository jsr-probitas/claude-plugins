---
paths: "**/*.probitas.ts"
---

# Probitas Scenario Structure

**Scenario** = sequential steps that depend on each other (`ctx.previous`).
**Scenario file** = grouping of related scenarios.

- Steps sharing context → same scenario
- Independent steps → separate scenarios

```typescript
// Single scenario in file
export default scenario("Test").step(...).build();

// Multiple scenarios in file
export default [
  scenario("Test A").step(...).build(),
  scenario("Test B").step(...).build(),
];
```

Always end with `.build()`.
