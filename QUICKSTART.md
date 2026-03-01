# Sprint Board - Quick Start

## 🎯 You're 2 Minutes Away

Everything is ready. Just need to deploy to GitHub Pages.

## Deploy Now

```bash
cd /Users/clanker/.openclaw/workspace/sprint

# One-time GitHub auth
gh auth login --web

# Deploy
./deploy.sh
```

That's it. Your Sprint Board will be live at:

**https://noahsclanker-sys.github.io/sprint/**

## What Changed

✅ **Readability fixed** - Text is much brighter and easier to read
✅ **Webhook added** - Task completions sync to `localhost:3456/task-update`
✅ **Git repo ready** - Just needs to be pushed

## Optional: Start Webhook Listener

```bash
node listener.js
```

This will log all task completions and can integrate with Hanuman.

---

**See DEPLOYMENT_STATUS.md for full details.**
