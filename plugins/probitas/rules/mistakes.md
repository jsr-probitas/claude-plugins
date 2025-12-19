---
paths: "**/*.probitas.ts"
---

# Probitas Common Mistakes

## Missing export default / .build()

```typescript
// ❌ BAD
const s = scenario("Test").step(() => {});

// ✅ GOOD
export default scenario("Test").step(() => {}).build();
```

## Hardcoded URL

```typescript
// ❌ BAD
client.http.createHttpClient({ url: "http://localhost:8080" });

// ✅ GOOD
client.http.createHttpClient({
  url: Deno.env.get("API_URL") ?? "http://localhost:8080",
});
```

## Step returns nothing

```typescript
// ❌ BAD - loses data
.step("Create", async (ctx) => {
  await ctx.resources.http.post("/users", { body: {} });
})

// ✅ GOOD - pass to next step
.step("Create", async (ctx) => {
  const res = await ctx.resources.http.post("/users", { body: {} });
  return res.json<{ id: number }>()!;
})
```

## Missing cleanup

```typescript
// ✅ GOOD - setup returns cleanup function
.setup(async (ctx) => {
  await ctx.resources.db.query("INSERT...");
  return async () => {
    await ctx.resources.db.query("DELETE...");
  };
})
```

## Unnecessary type casting

```typescript
// ❌ BAD - return is any, cast is redundant
const data = res.json() as { id: number };

// ✅ GOOD
const data = res.json(); // any

// ✅ GOOD
const data = res.json<{ id: number }>();
```

## Defensive null checks

```typescript
// ❌ BAD - test code, not production
const data = res.json<{ id: number }>();
if (data) {
  expect(data.id).toBe(1);
}

// ✅ GOOD - use ! or as
const data = res.json<{ id: number }>()!;
expect(data.id).toBe(1);
```

## Missing specialized methods

```typescript
// ❌ BAD - unclear error on failure
if (res.status !== 200) throw new Error("Failed");
expect(res.headers.get("content-type")).toContain("json");

// ✅ GOOD - use specialized methods for clear errors
expect(res).toHaveStatus(200);
expect(res).toHaveHeadersPropertyContaining("content-type", "json");
```
