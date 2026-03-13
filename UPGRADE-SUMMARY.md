# Sprint Dashboard Upgrade — March 13, 2026

## ✅ Completed Changes

### 1. Smart Batching (build-sprint.sh)
Replaced simple due-date batching with intelligent categorization:

- **Batch 1: Quick Wins** — Short, simple tasks (~10 min): "check X", "send Y", "review Z"
- **Batch 2: Must-Do Today** — Hard deadline today + critical overdue (≤2 days)
- **Batch 3: Calls & Outreach** — Calls, texts, emails, follow-ups, outreach
- **Batch 4: Deep Work** — Creative tasks: building, writing, creating, drafting
- **Batch 5: Admin & Finance** — Invoices, billing, payments, receipts
- **Batch 6: Backlog** — Overdue >2 days, stale tasks

**Rules:**
- Tasks go into the FIRST matching batch (priority order matters)
- Within each batch, sorted by due date (oldest first)
- Airtable tasks classified the same way (no separate dump)

### 2. Two-Way Completion Sync (index.html)
When you check/uncheck a task in the dashboard:
- Fires API call to mark complete/incomplete in Asana or Airtable
- Shows toast notification on success ("✓ Synced to Asana") or failure ("⚠ Sync failed")
- Non-blocking — UX doesn't freeze if API fails
- Works for both checking (complete) and unchecking (incomplete)

**API Endpoints:**
- Asana: `PUT /api/1.0/tasks/{gid}` with `{"data": {"completed": true/false}}`
- Airtable: `PATCH /v0/{BASE}/Tasks/{record_id}` with `{"fields": {"Status": "Complete"/"In Progress"}}`

### 3. Security Improvements
- API tokens moved from hardcoded values to `.env` file (gitignored)
- Browser-side tokens stored in localStorage (not committed to repo)
- Setup instructions in code comments

### 4. Updated Batch Titles (update-sprint-html.js)
Batch titles in the generated HTML now match the new smart categories.

## 🔧 Setup Required

To enable two-way sync in your browser:
1. Open the sprint dashboard
2. Open browser console (Cmd+Option+J)
3. Run (see `.env` file for actual token values):
```javascript
localStorage.setItem('sprint-api-tokens', JSON.stringify({
  asana: 'YOUR_ASANA_TOKEN',
  airtable: 'YOUR_AIRTABLE_TOKEN',
  airtableBase: 'appw2CNLQBWO3TvZ6'
}));
```
4. Reload the page

**Note:** Tokens are in the `.env` file (not committed to repo). Copy values from there.

## 📊 Test Results
Ran build-sprint.sh successfully:
- 12 Asana tasks fetched
- 0 Airtable tasks
- Organized into 6 batches (4 non-empty)
- Successfully pushed to GitHub Pages

## 🚀 Deployment
- Live at: https://noah-sparks.github.io/sprint/
- Auto-deploys on push to main branch
- Nightly rebuild at 2am PT via cron (if configured)

## 📝 Files Modified
1. `/Users/clanker/.openclaw/workspace/scripts/build-sprint.sh` — Smart batching logic
2. `/Users/clanker/.openclaw/workspace/scripts/update-sprint-html.js` — Batch title updates
3. `/Users/clanker/.openclaw/workspace/sprint/index.html` — Two-way sync + toast notifications
4. `/Users/clanker/.openclaw/workspace/sprint/.env` — API credentials (gitignored)
5. `/Users/clanker/.openclaw/workspace/sprint/.gitignore` — Protect sensitive files

## 🎯 What Didn't Change
- CSS/visual design (untouched)
- Supabase integration (untouched)
- "Move to tomorrow" feature (untouched)
- Progress bar logic (untouched)
- Batch switching UI (untouched)

## 🐛 Known Issues
None currently. If sync fails, check:
1. localStorage has valid tokens
2. Network tab shows API requests firing
3. Console for error messages

## 📚 Next Steps (Optional)
- Set up nightly cron for automatic rebuilds
- Monitor sync success rate
- Consider backend proxy for better token security (if dashboard becomes public)
