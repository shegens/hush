# Hush

One post. Per day. Make it count.

## Stack

- **Chain:** Lens Protocol (ZKsync L2)
- **Frontend:** Next.js + Tailwind
- **Contracts:** Solidity + Foundry
- **DB:** Postgres (off-chain decibels)

## Structure

```
apps/
  web/          Next.js frontend
contracts/
  src/          Solidity contracts
  test/         Foundry tests
packages/
  db/           DB schema
```

## Contracts

- `HushFeedRule` — enforces 1 post per 24h rolling window per author

## Dev

```bash
# Frontend
cd apps/web && npm install && npm run dev

# Contracts
cd contracts && forge test
```
