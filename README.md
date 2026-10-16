# Forward funding desk — starting draft

Public GitHub Pages draft with a monthly scholarship calendar, eligibility-stage filters, sponsor links, and device-local status controls for testing applied/denied filters.

The authenticated shared dashboard remains at https://lindsay-funding-desk.cheekybowl4096.chatgpt.site/ . This draft does not connect to its database or inbox. No private notes, emails, application history, profile documents, provider tokens, or account credentials are included.

Research snapshot: October 15, 2026. 453 leads are not 453 confirmed eligible awards. Stage categories are conditional and sponsor rules must be checked before applying. Exact dates only; unknown, rolling, and conflicting dates stay separate.

## Develop

`npm ci`, then `npm run dev`. `npm test` checks calendar parsing, stage filters and application exclusions. `npm run build` produces `docs/` for GitHub Pages. Commit the generated `docs/` directory to publish the draft.

Future work: invite the intended collaborator to the private workspace and configure supported read-only Gmail ingestion with reviewed decisions. GitHub Pages serves static files and is not the shared database host.
