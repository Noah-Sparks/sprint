-- Add columns for enhanced tracking (preserves existing data)

-- Track when a task was completed
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ;

-- Track which sprint day this task belonged to
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS sprint_key TEXT;

-- Track source: 'asana', 'airtable', or 'manual'
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS source TEXT DEFAULT 'manual';

-- Add index for weekly queries
CREATE INDEX IF NOT EXISTS idx_completed_at ON tasks(completed_at);
CREATE INDEX IF NOT EXISTS idx_sprint_key ON tasks(sprint_key);
CREATE INDEX IF NOT EXISTS idx_source ON tasks(source);

-- Backfill sprint_key for existing tasks (extract from older sprint keys if possible)
-- This is best-effort; new tasks will have it set properly
UPDATE tasks SET sprint_key = 'sprint-2026-03-03-yearly' WHERE sprint_key IS NULL AND created_at >= '2026-03-03';

COMMENT ON COLUMN tasks.completed_at IS 'Timestamp when task was marked done';
COMMENT ON COLUMN tasks.sprint_key IS 'Sprint identifier (e.g. sprint-2026-03-04)';
COMMENT ON COLUMN tasks.source IS 'Task source: asana, airtable, or manual';
