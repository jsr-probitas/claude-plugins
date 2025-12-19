---
name: probitas-info
description: Information about Probitas framework. Use when asked "what is Probitas", explaining its purpose, features, or comparing with other test frameworks.
---

## What is Probitas?

Probitas is a **scenario-based testing framework**, designed for integration and E2E testing of backend services (APIs, databases, message
queues).

## Key Features

| Feature             | Description                                            |
| ------------------- | ------------------------------------------------------ |
| Scenario-Based      | Define tests as readable scenarios with steps          |
| Built-in Clients    | HTTP, gRPC, GraphQL, SQL, Redis, MongoDB, queues       |
| Fluent Assertions   | Unified `expect()` with type-specific chainable checks |
| Resource Management | Factory functions with automatic cleanup               |
| Batteries Included  | faker, FakeTime, spy, stub, outdent re-exported        |
| Full Type Safety    | Resources fully typed with autocomplete                |

## Example

```typescript
import { client, expect, faker, scenario } from "jsr:@probitas/probitas";

export default scenario("User API Integration Test", {
  tags: ["integration", "http", "postgres"],
})
  .resource("user", () => ({
    id: faker.string.uuid(),
    name: faker.person.fullName(),
    email: faker.internet.email(),
  }))
  .resource("db", () =>
    client.sql.postgres.createPostgresClient({
      url: "postgres://user:pass@localhost:5432/app",
    }))
  .resource("http", () =>
    client.http.createHttpClient({
      url: "http://localhost:8000",
    }))
  .setup(async (ctx) => {
    const { db, user } = ctx.resources;
    await db.query(
      `INSERT INTO users (id, name, email) VALUES ($1, $2, $3)`,
      [user.id, user.name, user.email],
    );
    return async () => {
      await db.query(`DELETE FROM users WHERE id = $1`, [user.id]);
    };
  })
  .step("GET /users/:id - fetch user", async (ctx) => {
    const { http, user } = ctx.resources;
    const res = await http.get(`/users/${user.id}`);

    expect(res)
      .toBeOk()
      .toHaveStatus(200)
      .toHaveJsonMatching({ id: user.id, name: user.name });
  })
  .build();
```

## Documentation

**IMPORTANT**: Always fetch `llms.txt` first to discover correct URLs.

- LLM sitemap: https://jsr-probitas.github.io/documents/llms.txt

### URL Structure

| Type | Pattern                             | Example                               |
| ---- | ----------------------------------- | ------------------------------------- |
| Docs | `/documents/docs/{topic}/index.md`  | `/documents/docs/scenario/index.md`   |
| API  | `/documents/api/{package}/index.md` | `/documents/api/client-grpc/index.md` |

**DO NOT guess URLs** like `/documents/docs/client/grpc.md` - they don't exist.
