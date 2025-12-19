---
name: probitas-write
description: Writing Probitas scenarios. MUST BE USED when writing/editing E2E tests, creating scenarios, or working with *.probitas.ts files.
---

## Instructions

When this skill is triggered:

1. If project not initialized (no `probitas.jsonc`) → trigger `probitas-setup`
   skill first
2. **Delegate to the scenario-writer agent** (see invocation below)
3. After agent completes, trigger `probitas-run` skill to verify scenarios pass

### How to Invoke scenario-writer Agent

Simply state the delegation in your response text:

> "I'll use the scenario-writer agent to write this test."

Then describe the test requirements. Claude Code will automatically detect and
invoke the custom agent.

**Example:**

```
I'll use the scenario-writer agent to write an E2E test for the user
authentication API that:
- Tests login with valid credentials
- Tests login with invalid credentials
- Tests token refresh
```

**DO NOT** use `Task tool: subagent_type="scenario-writer"` - custom agents are
NOT invoked via the Task tool. Just state the delegation naturally.

---

## Rules (if writing directly)

If you MUST write directly (e.g., small fix), follow these rules strictly.

### Import

```typescript
import { client, expect, scenario, Skip } from "jsr:@probitas/probitas";
import { faker, FakeTime, spy, stub } from "jsr:@probitas/probitas";
```

### Template

```typescript
export default scenario("Test name", { tags: ["..."] })
  .resource("http", () =>
    client.http.createHttpClient({
      url: Deno.env.get("API_URL") ?? "http://localhost:8080",
    }))
  .step("Step name", async (ctx) => {
    const res = await ctx.resources.http.get("/endpoint");
    expect(res).toBeOk().toHaveStatus(200);
    return res.json<{ id: number }>()!;
  })
  .build();
```

### Scenario Structure (CRITICAL)

**Each scenario = steps that DEPEND on each other via `ctx.previous`.**

Before adding a step, ask: "Does this step need `ctx.previous`?"

- **YES** → Add to existing scenario
- **NO** → **MUST create separate scenario**

```typescript
// ❌ BAD - Independent tests in one scenario
scenario("Tests")
  .step("Test A", async (ctx) => {
    /* no ctx.previous */
  })
  .step("Test B", async (ctx) => {
    /* no ctx.previous - WRONG! */
  })
  .build();

// ✅ GOOD - Separate scenarios for independent tests
const http = () => client.http.createHttpClient({ url });
export default [
  scenario("Test A").resource("http", http).step(...).build(),
  scenario("Test B").resource("http", http).step(...).build(),
];
```

### Step Context

Available in `.resource()`, `.setup()`, `.step()`:

- `ctx.previous` - Previous step's return value
- `ctx.results` - All previous step results (tuple)
- `ctx.resources` - Registered resources by name
- `ctx.store` - Shared Map across steps
- `ctx.signal` - AbortSignal for cancelable operations

### Assertions (CRITICAL)

**NEVER use `if/throw` or manual checks. ALWAYS use `expect()` assertions.**

```typescript
// ❌ FORBIDDEN - if/throw
if (res.statusCode !== 0) {
  throw new Error(`Expected status 0, got ${res.statusCode}`);
}

// ❌ FORBIDDEN - JSON.stringify check
if (JSON.stringify(data).includes("token")) {
  throw new Error("Token found");
}

// ✅ CORRECT - use expect() assertions ONLY
expect(res)
  .toBeOk()
  .toHaveDataMatching({ statusCode: 0 })
  .not.toHaveDataProperty(["Metadata", "x-internal-token"]);
```

**Chain ALL assertions in ONE `expect()` call. Use array syntax for nested
paths.**

### Common Mistakes

```typescript
// ❌ Missing export default / .build()
const s = scenario("Test").step(() => {});
// ✅ CORRECT
export default scenario("Test").step(() => {}).build();

// ❌ Hardcoded URL
client.http.createHttpClient({ url: "http://localhost:8080" });
// ✅ CORRECT
client.http.createHttpClient({
  url: Deno.env.get("API_URL") ?? "http://localhost:8080",
});

// ❌ Step returns nothing (loses data for next step)
.step("Create", async (ctx) => {
  await ctx.resources.http.post("/users", { body: {} });
})
// ✅ CORRECT - return data for ctx.previous
.step("Create", async (ctx) => {
  const res = await ctx.resources.http.post("/users", { body: {} });
  return res.json<{ id: number }>()!;
})

// ❌ Missing cleanup in setup
.setup(async (ctx) => {
  await ctx.resources.db.query("INSERT...");
})
// ✅ CORRECT - return cleanup function
.setup(async (ctx) => {
  await ctx.resources.db.query("INSERT...");
  return async () => {
    await ctx.resources.db.query("DELETE...");
  };
})

// ❌ Defensive null checks (this is test code)
const data = res.json<{ id: number }>();
if (data) { expect(data.id).toBe(1); }
// ✅ CORRECT - use ! assertion
const data = res.json<{ id: number }>()!;
expect(data.id).toBe(1);

// ❌ Unnecessary type casting
const data = res.json() as { id: number };
// ✅ CORRECT - use generic
const data = res.json<{ id: number }>()!;
```

### Best Practices

- Descriptive step names ("Create user" not "Step 1")
- Return data for `ctx.previous`
- Use tags for filtering (`{ tags: ["api", "slow"] }`)
- One responsibility per step
- Use `.setup()` with cleanup for fixtures
- Register clients as `.resource()` for auto-cleanup
- Use `toHaveJsonMatching()` / `toHaveDataMatching()` for partial matching

### Checklist

- [ ] `export default` + `.build()`
- [ ] Resources via `.resource()`
- [ ] Setup returns cleanup function
- [ ] Env vars for URLs (not hardcoded)
- [ ] Fluent assertions with `expect()` - NO `if/throw`
- [ ] Independent tests → separate scenarios
- [ ] Tags for filtering
