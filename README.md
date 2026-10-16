# Sayscholar — full shared funding dashboard

Canonical app: https://sayscholar.app/ (also https://www.sayscholar.app/). The application runs in the owner’s Cloudflare account with a D1 database. GitHub Pages links to the secure app; it does not host a second independent copy of the private records.

## Features

- Funding charts for requested, confirmed, pending, and received amounts; currencies are separate.
- 453 research leads, application board, shared shortlist, ownership, notes, checklists, deadlines and portal links.
- Deadline calendar with selected-day panel, eligibility stages and applied/denied exclusions.
- Deduplicated email review queue. Gmail ingestion is not connected; imported excerpts require explicit review.
- Version checks reject stale simultaneous edits. Shared data refreshes every 30 seconds and on focus.
- Email/password sign-in, server-side authorization on every route and static asset, opaque revocable sessions, secure HttpOnly cookies, same-origin writes, login throttling and HTTPS.

## Privacy boundary

No login password, hash, session, email response, financial record, or private research profile is committed. Users and salted password hashes are provisioned directly into D1. A neutral sponsor catalog is included in `lib/opportunities.json`; the deployment’s enriched catalog lives in D1. Private reference reports in `public/research/` are excluded from Git and protected by the Worker at runtime. Research-stage labels are conditional and do not establish current eligibility by themselves.

## Deploy

1. `npm ci` and authenticate Wrangler to the intended Cloudflare account.
2. Review `wrangler.jsonc` account, database and custom-domain bindings. Do not replace an existing deployment or database without checking its owner and current data.
3. Apply migrations with `npx wrangler d1 migrations apply DB --remote`.
4. Provision an authorized user through `scripts/provision.mjs`, using private stdin JSON with email and password. The helper derives a random-salt PBKDF2 hash and writes only the hash to D1. It reads Wrangler’s local authorized OAuth credential without printing it. Optionally pass a private catalog JSON path; otherwise it seeds the neutral included catalog. The helper revokes sessions when provisioning a password.
5. `npm test`, `npx tsc --noEmit`, `npm run build`, and `npx wrangler deploy`.

No public self-registration or Google OAuth has been enabled. Login credentials do not create an email mailbox. To add separate accounts later, implement an owner-authorized account management flow; never add client-side password checks.

## Tests

`npm test` covers financial totals, date extraction, stage/status filters, hashing and token parsing. `scripts/seed-local-test.mjs` seeds a fictional local account only. Run Wrangler locally with `--host localhost` and then `node worker/integration.test.mjs` to test authorization, sessions, CSRF, concurrent edits, persistence and reviewed decisions. The bundled Wrangler runtime may need the documented local compatibility override `--compatibility-date 2026-05-22`; production uses the manifest date.

`scripts/verify-live.mjs` accepts private login JSON through hidden stdin and a DNS-verified edge address for a TLS-verified deployment check while resolver caches update. It saves the selected Gmail preference, verifies a durable read and logout, and does not add fictional awards or applications.

## Operational notes

Export shared backups from Workspace. Cloudflare D1 state is separate from GitHub source and the previous Sites deployment. Keep an export before future migrations. Account recovery/password changes require an authorized deployment operator; no email reset sender is configured. TLS/DNS propagation may temporarily differ by resolver after first domain activation.
