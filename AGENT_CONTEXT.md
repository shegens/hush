# AGENT_CONTEXT.md — Hush

## What
Private social platform. One post per day. Quality > quantity. High signal.

## Repo
`shegens/hush` (public for GitHub Pages)
Pages: https://shegens.github.io/hush/

## Auth
**Para** (getpara.com) — embedded wallet + SIWE. No gas, no transactions. Supports email/social onboarding for non-crypto users. Server verifies signature, issues JWT session.

## Chain (future)
Lens Protocol (ZKsync L2). `HushFeedRule.sol` ready for deployment. Gas sponsored via paymaster. v1 enforces 24h limit server-side only.

## Stack
- Smart contracts: Solidity + Foundry (`contracts/`)
- Frontend: Next.js + Tailwind (`apps/web/`)
- Auth: Para (wallet login, SIWE, no gas)
- DB: Postgres — posts + off-chain decibels (`packages/db/schema.sql`)
- Storage: Lens Storage Nodes (future)

## Design
- Background: `#FDF6EE` (cream)
- Parchment: `#F7EDE2`
- Accent: `#D96B10` (orange-wine)
- Pink: `#F46080` (heard state — full opacity; hover 60%; unheard stays orange)
- Handle/stat color: `#5C2E0E`
- Body text: `#221206`
- Muted: `#8C5828`
- Link hover: `#E87060`
- No emoji anywhere in UI
- Font: Georgia serif (posts), system-ui (chrome)
- Tone: soft, hushed, clean, minimal

## Terminology
- Like → **heard** (4-bar decibel icon)
- Post button → **speak**
- Follow → **tune in** / **tuned**
- Feed sort: **time** (chron) | **volume** (24h buckets, top decibels per day)
- Ambient noise: 0–5 slider, controls social graph radius — no labels, user discovers

## Core Rules
- 1 post per 24h rolling window (not calendar day)
- Deleting a post does NOT reset the cooldown
- Char limit: 999. Feed folds at 333 chars with "… read more"
- No follower/following counts — only **frequency** (degrees of separation: 0 = following, 1 = mutual in common, etc.)
- No exact decibel counts — 4 bar tiers: 1–9 / 10–99 / 100–999 / 1000+
- Unheard bars: orange at full opacity. Heard bars: pink `#F46080` full. Hover: pink 60%.

## Ambient Noise Levels (0–5)
- 0: your feed only (people you follow)
- 1: mutuals of mutuals
- 2: people your mutuals follow
- 3: people you follow (mutual or not) + their follows
- 4: one more ring outward
- 5: everyone

## Prototype Pages
- Feed: `/hush/index.html`
- Profile: `/hush/profile.html?u=@handle`
- Palette: `/hush/palette.html`
- Test users: @margaux (style), @roxy (nightlife), @tina (gossip), @celeste (dining)
- 9 posts each, 14-day spread, decibels 0–8800

## Contracts
- `HushFeedRule.sol` — 24h rolling cooldown per author, `TooSoon(nextAllowedAt)` error
- `HushFeedRule.t.sol` — 6 Foundry tests
- Foundry config: Lens RPC endpoints in `contracts/foundry.toml`

## TODO
- [ ] **Waitlist system**
  - Para login creates account, auto-inserts as `pending`
  - Alex greenlists addresses → `approved`
  - `pending` users: read-only (feed visible, no speak/hear/tune in)
  - Admin route (`/admin`) — wallet-authed, shows pending list, approve button
  - DB: `users` table — `address`, `status` (pending|approved), `created_at`
- [ ] **PWA** (after platform built out)
  - Service worker + manifest
  - Push notification when cooldown hits 0 ("you can speak again")
- [ ] Para auth integration
- [ ] Next.js app scaffold with real API routes
- [ ] Postgres setup + Drizzle or Prisma ORM
- [ ] Real feed pagination
- [ ] Profile photos
- [ ] Notifications page
- [ ] DMs ("whispers"?)
- [ ] Lens mainnet deployment (future v2)
