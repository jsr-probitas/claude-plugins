---
name: scenario-writer
description: Create and edit *.probitas.ts files. Use when writing new Probitas scenarios, editing existing ones, or implementing E2E tests.
---

## Template

```typescript
import { client, expect, scenario } from "jsr:@probitas/probitas";

export default scenario("Test name", { tags: ["..."] })
  .resource("http", () =>
    client.http.createHttpClient({
      url: Deno.env.get("API_URL") ?? "http://localhost:8080",
    }))
  .step("Step name", async (ctx) => {
    const res = await ctx.resources.http.post("/endpoint", { body: {} });
    expect(res).toBeOk().toHaveStatus(200);
    return res.json<{ id: number }>()!;
  })
  .build();
```

## Workflow

1. Write scenario following template above
2. Run `/probitas:check`, fix issues
3. If unsure, fetch specific API docs from links below

## Checklist

- [ ] `export default` + `.build()`
- [ ] Resources via `.resource()`
- [ ] Setup returns cleanup function
- [ ] Env vars for URLs
- [ ] Chain assertions with `expect()`
- [ ] Tags for filtering
- [ ] File: `probitas/{name}.probitas.ts`

## Docs

Guides:

- Scenario: https://jsr-probitas.github.io/documents/docs/scenario/index.md
- Client: https://jsr-probitas.github.io/documents/docs/client/index.md
- Expect: https://jsr-probitas.github.io/documents/docs/expect/index.md

API Reference (by client):

- HTTP: https://jsr-probitas.github.io/documents/api/client-http/index.md
- gRPC: https://jsr-probitas.github.io/documents/api/client-grpc/index.md
- ConnectRPC: https://jsr-probitas.github.io/documents/api/client-connectrpc/index.md
- GraphQL: https://jsr-probitas.github.io/documents/api/client-graphql/index.md
- PostgreSQL: https://jsr-probitas.github.io/documents/api/client-sql-postgres/index.md
- MySQL: https://jsr-probitas.github.io/documents/api/client-sql-mysql/index.md
- SQLite: https://jsr-probitas.github.io/documents/api/client-sql-sqlite/index.md
- DuckDB: https://jsr-probitas.github.io/documents/api/client-sql-duckdb/index.md
- Redis: https://jsr-probitas.github.io/documents/api/client-redis/index.md
- MongoDB: https://jsr-probitas.github.io/documents/api/client-mongodb/index.md
- Deno KV: https://jsr-probitas.github.io/documents/api/client-deno-kv/index.md
- RabbitMQ: https://jsr-probitas.github.io/documents/api/client-rabbitmq/index.md
- SQS: https://jsr-probitas.github.io/documents/api/client-sqs/index.md

Core API:

- Scenario: https://jsr-probitas.github.io/documents/api/scenario/index.md
- Expect: https://jsr-probitas.github.io/documents/api/expect/index.md
