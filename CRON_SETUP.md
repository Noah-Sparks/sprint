# Cron Job Setup for Nightly Sprint Builder

## macOS Permissions Required

Before the cron job will work, you need to grant permissions:

1. **System Settings** → **Privacy & Security** → **Full Disk Access**
2. Add `/usr/sbin/cron` to the allowed apps
3. Or add your terminal app (Terminal.app, iTerm2, etc.)

## Install the Cron Job

```bash
crontab -e
```

Add this line (runs at 2:00 AM PT):

```
0 9 * * * /Users/clanker/.openclaw/workspace/scripts/build-sprint.sh >> /Users/clanker/.openclaw/workspace/logs/sprint-builder.log 2>&1
```

**Note:** The time is 9:00 UTC which equals:
- 2:00 AM PDT (Pacific Daylight Time, Mar-Nov)
- 1:00 AM PST (Pacific Standard Time, Nov-Mar)

Adjust if needed:
- For 2 AM year-round PT: Use two entries or a script that detects timezone
- For different time: Change `0 9` to `MINUTE HOUR` in 24-hour UTC format

## Verify Installation

```bash
# List current crontab
crontab -l

# Check cron logs (macOS)
log show --predicate 'process == "cron"' --last 1h

# Check sprint builder logs
tail -f /Users/clanker/.openclaw/workspace/logs/sprint-builder.log
```

## Manual Test

Run the script manually to test:

```bash
cd /Users/clanker/.openclaw/workspace
./scripts/build-sprint.sh
```

## Troubleshooting

If the cron job doesn't run:

1. **Check permissions:** Full Disk Access must be granted
2. **Check PATH:** Cron runs with minimal environment. The script uses full paths.
3. **Check logs:** `tail /Users/clanker/.openclaw/workspace/logs/sprint-builder.log`
4. **Test manually:** Run the script directly to see errors

## Alternative: OpenClaw Scheduler

Instead of system cron, you can use OpenClaw's built-in scheduler:

```bash
openclaw cron add "0 9 * * *" "/Users/clanker/.openclaw/workspace/scripts/build-sprint.sh"
```

This may have better permissions handling and logging.
