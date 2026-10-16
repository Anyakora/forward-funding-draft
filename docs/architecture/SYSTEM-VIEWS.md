# System views
Browser React UI → authenticated Worker → D1 shared workspace, research catalog, audits, source checks and discoveries. All static assets and APIs pass through session authorization. Cron calls a bounded read-only public-source scanner using catalog URLs; it writes only monitoring tables. Daily Codex research uses primary sources and the scoped audit/discovery publisher. The app never stores portal passwords.

Audit data flows from lib/funding-audit.json seeds plus versioned D1 overrides to /api/audits, then AuditCenter and application templates. Human application answers are stored separately. Discoveries remain pending eligibility review and do not enter monetary totals.

Degree-aware screening joins protected D1 assessments to public sponsor summaries before rendering cards, modal requirements, audit filters and calendar gates. Legacy match flags no longer determine current fit.
