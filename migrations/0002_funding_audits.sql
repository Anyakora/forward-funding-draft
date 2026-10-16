CREATE TABLE IF NOT EXISTS opportunity_audits(id TEXT PRIMARY KEY,payload TEXT NOT NULL,version INTEGER NOT NULL DEFAULT 1,updated_by TEXT NOT NULL,updated_at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS audit_history(id TEXT PRIMARY KEY,opportunity_id TEXT NOT NULL,payload TEXT NOT NULL,actor TEXT NOT NULL,at TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS opportunity_scans(id TEXT PRIMARY KEY,url TEXT NOT NULL,status INTEGER,content_hash TEXT,last_checked TEXT NOT NULL,changed_at TEXT,needs_review INTEGER NOT NULL DEFAULT 0,note TEXT);
CREATE TABLE IF NOT EXISTS scan_runs(id TEXT PRIMARY KEY,started_at TEXT NOT NULL,finished_at TEXT,checked INTEGER NOT NULL DEFAULT 0,changed INTEGER NOT NULL DEFAULT 0,blocked INTEGER NOT NULL DEFAULT 0,state TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS discovered_opportunities(id TEXT PRIMARY KEY,payload TEXT NOT NULL,version INTEGER NOT NULL DEFAULT 1,state TEXT NOT NULL DEFAULT 'Needs eligibility review',created_at TEXT NOT NULL,updated_at TEXT NOT NULL);
CREATE INDEX IF NOT EXISTS scan_checked_idx ON opportunity_scans(last_checked);
CREATE INDEX IF NOT EXISTS audit_history_opportunity ON audit_history(opportunity_id,at);
