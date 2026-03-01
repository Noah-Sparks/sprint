# Sprint Board v2 - Credentials & Deployment Info

## Supabase Database
- **URL:** https://cfnuhjfceceojfykznnm.supabase.co
- **Anon Key:** sb_publishable_oefauf4bsK7QBNecphPI9w_AGrjl7UK
- **DB Password:** 6IAAz7dkZy7xzQ5Q
- **Dashboard:** https://supabase.com/dashboard/project/cfnuhjfceceojfykznnm

### Database Status
✅ Table `tasks` created successfully with:
- Columns: id, task_id, name, detail, section, done, moved_to, created_at, updated_at
- Row Level Security enabled with "Allow all" policy
- ✅ Seeded with 22 tasks from the current sprint board

## GitHub Repository
- **Repo:** https://github.com/Noah-Sparks/sprint
- **Branch:** main
- **Latest Commit:** v2: Supabase backend integration with offline fallback
- **Status:** ✅ Pushed successfully

## Vercel Deployment
- **Status:** ⚠️ Requires SMS verification to complete account setup
- **Account Email:** noahsclanker@gmail.com
- **Account Name:** Noah Sparks
- **Plan:** Hobby (free)

### To Complete Vercel Deployment:
1. Go to https://vercel.com/signup
2. Sign up with GitHub (noahsclanker-sys account)
3. Complete SMS verification when prompted
4. Import the `Noah-Sparks/sprint` repository
5. Deploy with default settings (no build command needed for static HTML)

## Alternative: GitHub Pages
The repo is already configured and can be deployed to GitHub Pages:
1. Go to https://github.com/Noah-Sparks/sprint/settings/pages
2. Under "Source", select "Deploy from a branch"
3. Select branch: `main` and folder: `/ (root)`
4. Click Save
5. Site will be available at: https://noah-sparks.github.io/sprint/

## Features Implemented
✅ Supabase backend integration
✅ Offline fallback with localStorage
✅ Real-time sync between Supabase and localStorage
✅ Task completion tracking
✅ Move to tomorrow functionality
✅ Improved readability (brighter text colors)
✅ All 22 sprint tasks seeded in database

## Testing
To test locally:
```bash
cd /Users/clanker/.openclaw/workspace/sprint
open index.html
```

The board will:
- Load tasks from Supabase on page load
- Fall back to localStorage if offline
- Sync all changes to both Supabase and localStorage
- Work completely offline with localStorage backup
