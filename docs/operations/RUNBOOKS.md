# Operations
Apply migrations locally and remotely before deploying dependent code. Export audit versions with scripts/export-audits.mjs. Publish through scripts/publish-audits.mjs; inspect live exports for skipped version conflicts. Cloudflare Cron checks oldest 18 public sources every 30 minutes; check scan_runs for failure. Never bypass WAF, CAPTCHA or rate limits. Local tests require scripts/seed-local-test.mjs and wrangler dev on port8788.

Rollback: redeploy the previous Worker version; retain additive tables and shared user data. Disable triggers to stop scans, and pause the daily SayScholar heartbeat if requested. Do not drop D1 tables to revert a UI. OAuth expiry prevents local agent publishing; keep researched changes locally and reconnect authorized Wrangler access.
