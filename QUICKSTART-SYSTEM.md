# Sprint System - Quick Start Guide

## ✅ What's Done

The entire automated sprint system is **built and deployed**. Here's what you have:

- ✅ **Nightly sprint builder** that pulls from Asana, Airtable, and custom priorities
- ✅ **Enhanced dashboard** with source tracking and weekly recap
- ✅ **March 4 sprint** deployed and ready at https://noah-sparks.github.io/sprint/
- ✅ **Smart prioritization** (morning must-dos → today → this week)
- ✅ **Automatic GitHub deployment** (changes push to GitHub Pages instantly)

## 🚀 Two Steps to Activate

### Step 1: Run Database Migration (2 minutes)

This enables the "This Week" recap feature:

1. Go to https://supabase.com/dashboard/project/cfnuhjfceceojfykznnm/sql/new
2. Paste this SQL:

```sql
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ;
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS sprint_key TEXT;
ALTER TABLE tasks ADD COLUMN IF NOT EXISTS source TEXT DEFAULT 'manual';
CREATE INDEX IF NOT EXISTS idx_completed_at ON tasks(completed_at);
CREATE INDEX IF NOT EXISTS idx_sprint_key ON tasks(sprint_key);
CREATE INDEX IF NOT EXISTS idx_source ON tasks(source);
```

3. Click "Run"
4. Done!

### Step 2: Install Cron Job (3 minutes)

This makes the nightly build automatic:

**Option A: Traditional cron (recommended)**

1. Grant permissions:
   - System Settings → Privacy & Security → Full Disk Access
   - Add `/usr/sbin/cron` to allowed apps

2. Install cron job:
   ```bash
   crontab -e
   ```

3. Add this line:
   ```
   0 9 * * * /Users/clanker/.openclaw/workspace/scripts/build-sprint.sh >> /Users/clanker/.openclaw/workspace/logs/sprint-builder.log 2>&1
   ```

4. Save and exit (in vi: press `i` to insert, paste, press `Esc`, type `:wq`)

**Option B: OpenClaw scheduler (easier)**

```bash
openclaw cron add "0 9 * * *" "/Users/clanker/.openclaw/workspace/scripts/build-sprint.sh"
```

### Optional: Fix Git Warnings

```bash
cd /Users/clanker/.openclaw/workspace/sprint
git config user.name "Noah's Clanker"
git config user.email "noahsclanker@gmail.com"
```

## 📖 Daily Usage

### Every Night Before Bed

Edit your custom priorities for tomorrow:

```bash
code /Users/clanker/.openclaw/workspace/sprint/tomorrow-priorities.json
```

**Example:**
```json
[
  {
    "id": "custom-morning-1",
    "name": "Your morning task",
    "detail": "More details",
    "source": "manual",
    "priority": "custom-morning",
    "tags": []
  },
  {
    "id": "custom-afternoon-1",
    "name": "Your afternoon task",
    "detail": "",
    "source": "manual",
    "priority": "custom-afternoon",
    "tags": []
  }
]
```

Or just leave it empty `[]` and let Asana/Airtable tasks fill the sprint automatically.

### Every Morning

1. Visit https://noah-sparks.github.io/sprint/
2. See your fresh sprint (auto-built at 2am PT)
3. Start checking off tasks!

### End of Week

Click the **"This Week"** button to see everything you accomplished, grouped by day.

## 🔧 Manual Build

Want to rebuild the sprint immediately without waiting for 2am?

```bash
cd /Users/clanker/.openclaw/workspace
./scripts/build-sprint.sh
```

This will build tomorrow's sprint (one day from now).

## 📁 Key Files

| File | Purpose |
|------|---------|
| `sprint/index.html` | The dashboard (auto-updated nightly) |
| `sprint/tomorrow-priorities.json` | Your custom tasks for tomorrow |
| `scripts/build-sprint.sh` | Main builder script |
| `scripts/update-sprint-html.js` | HTML updater |
| `sprint/CRON_SETUP.md` | Detailed cron instructions |
| `memory/2026-03-04-sprint-system.md` | Full system documentation |

## 🆘 Troubleshooting

**Q: The sprint didn't update overnight**
- Check cron is running: `crontab -l`
- Check logs: `tail /Users/clanker/.openclaw/workspace/logs/sprint-builder.log`
- Check permissions: Full Disk Access for cron

**Q: Tasks aren't syncing to Supabase**
- Did you run the database migration? (Step 1 above)
- Check browser console for errors

**Q: "This Week" button shows no tasks**
- Run the database migration (Step 1 above)
- Mark some tasks as done and wait a few seconds
- Click "This Week" again

**Q: How do I add Airtable event tasks?**
- They pull automatically if:
  - Due Date is within next 3 days
  - Status is not "Complete"

**Q: Can I change the build time?**
- Edit the cron schedule: `crontab -e`
- Format: `MINUTE HOUR * * *` (in UTC)
- 2am PT = 9am UTC (during PDT) or 10am UTC (during PST)

## 📊 What Gets Pulled

**From Asana:**
- Tasks assigned to you
- Not completed
- Due: overdue, today, tomorrow, or day after tomorrow
- Automatically categorized by due date

**From Airtable:**
- Tasks table
- Status != Complete
- Due Date within next 3 days
- Pulls the linked Event name as detail

**From Custom Priorities:**
- Your manual entries in `tomorrow-priorities.json`
- Always appear first (morning or afternoon batches)

## 🎯 Priority Order

The system sorts tasks like this:

1. **Batch 1 (Morning Must-Dos):** Your custom morning tasks + urgent overdue
2. **Batch 2 (Today):** Your custom afternoon tasks + Asana tasks due today
3. **Batch 3 (This Week):** Tomorrow tasks + Airtable event tasks
4. **Batch 4 (Recurring):** Other Asana tasks

## 🏷️ Auto-Tags

Tasks get tagged automatically based on their names:

- "call" or "phone" → CALL (orange)
- "text" or "email" or "send" → TEXT (green)
- "pay" or "invoice" → PAY (red)
- "draft" or "write" → DRAFT (blue)
- "create" or "make" → CREATE (purple)

Plus a source tag: **asana**, **airtable**, or **manual**

## ✨ Features

- **Smart batching** - Tasks grouped by priority and timing
- **Source tracking** - See where each task came from
- **Weekly recap** - Review your week's accomplishments
- **Move to tomorrow** - Defer tasks with one click
- **Notes field** - Jot down themes, attendee counts, etc.
- **Progress tracking** - Visual progress bar
- **Auto-sync** - Everything saves to Supabase automatically
- **Zero maintenance** - Just runs every night

## 🎉 You're All Set!

Once you complete the two activation steps above, you have a fully automated sprint system that:

- Pulls from all your sources
- Builds a smart, prioritized daily sprint
- Deploys it automatically
- Tracks your progress
- Shows you weekly recaps

**Just complete Step 1 and Step 2, then enjoy your automated mornings!** 🚀
