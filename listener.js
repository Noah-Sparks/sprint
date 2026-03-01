#!/usr/bin/env node
/**
 * Sprint Board webhook listener
 * - Logs task completions to file (Hanuman reads this)
 * - Syncs to Asana via API
 * - Updates daily memory log
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const PORT = 3456;
const LOG_FILE = path.join(__dirname, 'task-completions.log');
const MEMORY_DIR = '/Users/clanker/.openclaw/workspace/memory';
const ASANA_TOKEN = '2/1212673880804841/1213444609854993:b74c67e14ec939a404c1b3ec5d614548';
const ASANA_WORKSPACE = '1208267418625813';

const server = http.createServer((req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') { res.writeHead(200); res.end(); return; }

  if (req.method === 'POST' && req.url === '/task-update') {
    let body = '';
    req.on('data', chunk => { body += chunk.toString(); });
    req.on('end', () => {
      try {
        const data = JSON.parse(body);
        const { taskId, taskName, done, timestamp } = data;

        // 1. Log to file
        const logEntry = `${new Date(timestamp).toISOString()} | ${taskId} | ${done ? 'DONE' : 'UNDONE'} | ${taskName}\n`;
        fs.appendFileSync(LOG_FILE, logEntry);

        // 2. Update daily memory
        try {
          const today = new Date().toISOString().split('T')[0];
          const memFile = path.join(MEMORY_DIR, `${today}.md`);
          if (fs.existsSync(memFile)) {
            let content = fs.readFileSync(memFile, 'utf8');
            if (!content.includes('## Sprint Progress')) {
              content += '\n\n## Sprint Progress\n';
            }
            const icon = done ? '✅' : '⬜';
            const time = new Date(timestamp).toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' });
            content += `- ${icon} ${time}: ${taskName.replace(/<[^>]*>/g, '').trim()}\n`;
            fs.writeFileSync(memFile, content);
          }
        } catch (e) { console.error('Memory update failed:', e.message); }

        // 3. Console
        const icon = done ? '✅' : '⬜';
        const time = new Date(timestamp).toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' });
        console.log(`${time} ${icon} ${taskName.replace(/<[^>]*>/g, '').trim()}`);

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ success: true }));

      } catch (err) {
        console.error('Error:', err);
        res.writeHead(400);
        res.end(JSON.stringify({ error: 'Bad request' }));
      }
    });
  } else {
    res.writeHead(404);
    res.end('Not found');
  }
});

server.listen(PORT, () => {
  console.log(`📡 Sprint listener on http://localhost:${PORT}`);
  console.log(`📝 Logging to: ${LOG_FILE}`);
  console.log(`🧠 Updating memory in: ${MEMORY_DIR}`);
  console.log(`\n👀 Watching for task completions...\n`);
});

process.on('SIGINT', () => { server.close(() => process.exit(0)); });
