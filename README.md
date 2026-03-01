# Sprint Board

Noah's permanent task tracker with webhook sync to Hanuman.

## ✅ Completed

1. **Enhanced Readability**
   - Task names now use bright `#f0f0f0` color
   - Task details use lighter `#9898a0` color
   - Section headers more visible with `#b0b0b8`
   - Overall better contrast for dark theme

2. **Webhook Integration**
   - Checkbox toggles send POST to `http://localhost:3456/task-update`
   - Payload: `{taskId, taskName, done, timestamp}`
   - Silent fail - won't break UI if endpoint unavailable
   - Hanuman can run listener to sync to memory/Asana

3. **Git Repository Initialized**
   - Local git repo created and committed
   - Ready to push to GitHub

## 🚀 Deploy to GitHub Pages

### Quick Deploy (2 minutes)

Run the deployment script:
```bash
cd /Users/clanker/.openclaw/workspace/sprint
./deploy.sh
```

If GitHub CLI isn't authenticated, choose one of these options:

### Option A: Authenticate GitHub CLI (Fastest)
```bash
# Run this command and follow the prompts
gh auth login --web

# Then run the deploy script
./deploy.sh
```

### Option B: Manual Setup (Alternative)
1. Visit https://github.com/new
2. Create repository:
   - Name: **sprint**
   - Owner: **noahsclanker-sys**
   - Public
3. Push code:
```bash
cd /Users/clanker/.openclaw/workspace/sprint
git remote add origin https://github.com/noahsclanker-sys/sprint.git
git push -u origin main
```
4. Enable GitHub Pages:
   - Go to repo Settings → Pages
   - Source: Deploy from **main** branch
   - Root directory: **/ (root)**
   - Save

### 🔗 Live URL (after deployment)
```
https://noahsclanker-sys.github.io/sprint/
```

**Note:** First deployment takes 1-2 minutes. Check deployment status at:
`https://github.com/noahsclanker-sys/sprint/actions`

## 🔄 Webhook Listener Setup

To enable Hanuman to receive task updates, run a simple listener:

```javascript
// listener.js - Simple webhook receiver
const express = require('express');
const fs = require('fs');
const app = express();
app.use(express.json());

app.post('/task-update', (req, res) => {
  const {taskId, taskName, done, timestamp} = req.body;
  
  // Log to file
  const logEntry = `${timestamp} | ${taskId} | ${taskName} | ${done ? 'DONE' : 'UNDONE'}\n`;
  fs.appendFileSync('task-completions.log', logEntry);
  
  // TODO: Sync to Asana, update MEMORY.md, etc.
  console.log(`✓ ${done ? '✅' : '⬜'} ${taskName}`);
  
  res.sendStatus(200);
});

app.listen(3456, () => console.log('📡 Listening on http://localhost:3456'));
```

Run with: `node listener.js`

## 📁 Files

- `index.html` - Sprint board (standalone, no dependencies)
- `deploy.sh` - Deployment script
- `README.md` - This file

## 🎯 Features

- ✅ Clean, readable dark theme
- ✅ Progress tracking
- ✅ Tomorrow/Later task management  
- ✅ Local storage persistence
- ✅ Notes section
- ✅ Webhook sync for AI assistant
- ✅ Mobile responsive
