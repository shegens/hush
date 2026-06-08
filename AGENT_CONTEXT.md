# AGENT_CONTEXT.md — Hush

## What
Private social platform. One post per day. Quality > quantity. High signal.

## Chain
Lens Protocol (ZKsync L2). Feed Rules enforce 1-post/day limit onchain.
Gas sponsored via paymaster — free UX for users.

## Repo
`shegens/hush` (public for GitHub Pages)
Token: [token in TOOLS.md]
Pages: https://shegens.github.io/hush/

## Stack
- Smart contracts: Solidity + Foundry (`contracts/`)
- Frontend: Next.js + Tailwind (`apps/web/`)
- Auth: Lens account (wallet-based)
- Storage: Lens Storage Nodes
- DB: Postgres — off-chain decibels (`packages/db/schema.sql`)

## Design
- Palette: cream `#FDF6EE`, orange-wine `#D96B10`, pink `#F46080`
- Handle/stat color: `#5C2E0E`
- Cream bg: `#FDF6EE`, parchment: `#F7EDE2`
- Tone: soft, hushed, clean — no noise, no emoji in UI
- Font: Georgia serif for posts, system-ui for UI chrome

## Terminology
- Like → **heard** (decibels icon, 4 ascending bars)
- Post button → **speak**
- Follow → **tune in** / **tuned**
- Decibels display: 4-bar icon, opacity-based (orange unheard, pink `#F46080` heard at 100%, hover at 60%)
- Feed sort: **time** (chronological) or **volume** (24h buckets, top decibels per day)
- Ambient noise: slider 0–5, controls social graph radius of feed (no labels — user discovers)

## Core Rules
- 1 post per 24h rolling window (not calendar day) — enforced onchain via HushFeedRule.sol
- Deleting a post does NOT reset the cooldown
- Char limit: 999. Posts fold at 333 chars with "… read more"
- No follower/following counts — only **frequency** (degrees of separation)
- No exact decibel counts — bar shading encodes tiers (1–9, 10–99, 100–999, 1000+)

## Prototype Pages
- Feed: `/hush/index.html`
- Profile: `/hush/profile.html?u=@handle`
- Palette picker: `/hush/palette.html`
- Test users: @margaux, @roxy, @tina, @celeste (9 posts each, 14-day spread)

## Contracts
- `HushFeedRule.sol` — 24h rolling cooldown per author
- `HushFeedRule.t.sol` — 6 Foundry tests

## TODO
- [ ] **PWA conversion** (after platform is built out)
  - Service worker + manifest
  - Push notification when user's 24h cooldown hits 0 ("you can speak again")
- [ ] Lens mainnet deployment
- [ ] Real auth (Lens wallet)
- [ ] Real feed from Lens API
- [ ] Profile photos
- [ ] DMs ("whispers"?)
- [ ] Notifications page
