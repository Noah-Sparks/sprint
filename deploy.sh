#!/bin/bash
# Deploy Sprint Board to GitHub Pages
# Quick 2-minute setup

set -e

echo "🚀 Deploying Sprint Board to GitHub Pages..."
echo ""

# Method 1: Try gh CLI (fastest if authenticated)
if gh auth status &>/dev/null 2>&1; then
  echo "✓ Using authenticated GitHub CLI"
  
  # Create repo
  if ! gh repo view noahsclanker-sys/sprint &>/dev/null; then
    echo "📦 Creating repository..."
    gh repo create noahsclanker-sys/sprint --public --description "Noah's Sprint Board"
  fi
  
  # Push
  cd /Users/clanker/.openclaw/workspace/sprint
  git remote remove origin 2>/dev/null || true
  git remote add origin https://github.com/noahsclanker-sys/sprint.git
  git branch -M main
  git push -u origin main --force
  
  # Enable Pages
  echo "🌐 Enabling GitHub Pages..."
  gh api repos/noahsclanker-sys/sprint/pages -X POST \
    -f source[branch]=main -f source[path]=/ 2>/dev/null || echo "✓ Pages already enabled"
    
else
  # Method 2: Manual auth flow
  echo "⚠️  GitHub CLI not authenticated."
  echo ""
  echo "Quick setup (choose one):"
  echo ""
  echo "OPTION A - Web authentication (recommended):"
  echo "  1. Run: gh auth login --web"
  echo "  2. Copy the code shown"
  echo "  3. Visit the URL and paste the code"
  echo "  4. Re-run this script"
  echo ""
  echo "OPTION B - Create repo manually (2 minutes):"
  echo "  1. Visit: https://github.com/new"
  echo "  2. Repository name: sprint"
  echo "  3. Owner: noahsclanker-sys"
  echo "  4. Public repository"
  echo "  5. Click 'Create repository'"
  echo "  6. Then run these commands:"
  echo ""
  echo "     cd /Users/clanker/.openclaw/workspace/sprint"
  echo "     git remote add origin https://github.com/noahsclanker-sys/sprint.git"
  echo "     git push -u origin main"
  echo ""
  echo "  7. Go to repo Settings → Pages → Source: Deploy from main branch"
  echo ""
  exit 1
fi

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🔗 Sprint Board URL:"
echo "   https://noahsclanker-sys.github.io/sprint/"
echo ""
echo "⏰ First deploy takes ~2 minutes. Check:"
echo "   https://github.com/noahsclanker-sys/sprint/actions"
