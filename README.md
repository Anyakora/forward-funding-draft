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

## Application inputs and portal audit (October 15, 2026)

Application records support exact prompt/answer fields, source evidence, confirmation IDs, and dated submission copies. First transition to Submitted or explicit archive request creates a server-side copy; later edits preserve prior copies. Custom templates and portal setup records save through version-checked D1 settings. Backup import preserves recorded histories for new records and never overwrites existing shared records. Password and sensitive identifier values are stripped server-side.

All 453 sponsor links received an HTTP reachability check; 40 priority opportunities received a separate application-route audit. The checked-in audits distinguish verified public fields, account-gated applications, and unverified routes. Verified fields are available in the application editor's template selector; starter templates remain explicitly unverified. No external account creation or scholarship submission is implied by a saved dashboard record. The Gmail preference and manual email-review queue do not establish a live Gmail ingestion connection.

## Full-catalog evidence review and daily monitoring

Audit & discovery contains a record for each of the 453 retained leads. Award selection type, funding evidence, visible form coverage, source dates, marketing/fee cautions and eligibility limitations are independent fields. Current snapshot: 258 classified records, 195 substantively unverified, 130 blocked/unresolved, 58 login-gated, 37 historical/closed. Eighteen records explicitly document endowments. The 896 field/requirement labels include published submission requirements and partial forms, not 896 completed answers or 453 complete portal schemas.

`/api/audits` merges checked-in sponsor evidence with versioned D1 overrides. Audit fields always have blank answer values; application answers stay in the workspace. Discovery leads remain outside application/funding totals pending review. Use `scripts/export-audits.mjs <output-json>` before editing and `scripts/publish-audits.mjs <input-json>` afterward. Use `--discoveries` for a new-lead list; use `--local` only for fictional tests. The publisher cannot write application outcomes or inbox records. It skips version conflicts, so export again to verify persisted results.

Cloudflare Cron checks the 18 oldest source pages every30minutes, approximately one pass per13hours when runs succeed. Availability and stable text fingerprints flag changes; they do not establish award legitimacy, current eligibility or complete forms. No authentication/anti-bot gate is bypassed. Manual scans use same-origin session-protected `/api/scans`. The separate SayScholar daily funding audit heartbeat researches primary sources and queues new leads; local authorized Cloudflare access is needed to publish those changes. No Dots account is required for these two configured monitoring paths. Gmail ingestion and third-party portal single sign-on remain unconnected.
