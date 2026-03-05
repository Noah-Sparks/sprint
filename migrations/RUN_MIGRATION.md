# Database Migration Instructions

## Step 1: Run the Schema Upgrade

Go to https://supabase.com/dashboard/project/cfnuhjfceceojfykznnm/sql/new

Paste and run this SQL:

```sql
-- Add tracking columns
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ;
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS sprint_key TEXT;
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS source TEXT DEFAULT 'manual';

-- Add indexes for fast queries
CREATE INDEX IF NOT EXISTS idx_completed_at ON tasks(completed_at);
CREATE INDEX IF NOT EXISTS idx_sprint_key ON tasks(sprint_key);
CREATE INDEX IF NOT EXISTS idx_source ON tasks(source);

-- Backfill existing tasks
UPDATE tasks SET sprint_key = 'sprint-2026-03-03-yearly' WHERE sprint_key IS NULL AND created_at >= '2026-03-03';

-- Verify
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'tasks' ORDER BY ordinal_position;
```

## Step 2: Verify

After running, you should see these new columns:
- `completed_at` (timestamptz) - When task was marked done
- `sprint_key` (text) - Which sprint day (e.g. sprint-2026-03-04)
- `source` (text) - Where it came from (asana/airtable/manual)

## Test Query

```sql
-- See completed tasks this week
SELECT task_id, name, completed_at, sprint_key, source
FROM tasks
WHERE completed_at >= NOW() - INTERVAL '7 days'
ORDER BY completed_at DESC;
```
