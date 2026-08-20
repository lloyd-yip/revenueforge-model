#!/usr/bin/env bash
# Deploy the model to GitHub Pages with a fresh build stamp.
#   ./deploy.sh "commit message"
set -e
cd "$(dirname "$0")"
SRC=/private/tmp/claude-501/-Users-lloydyip-Code/85c25659-3537-4b2b-83f4-104eef363d90/scratchpad/revenueforge-model.html
STAMP=$(date +%m%d-%H%M)
cp "$SRC" index.html
# stamp this build so the page can tell whether it is the newest one
N=$(grep -c '__BUILD__' index.html || true)
if [ "$N" != "1" ]; then echo "ABORT: expected exactly one __BUILD__ placeholder, found $N"; exit 1; fi
sed -i '' "s/__BUILD__/$STAMP/" index.html
cp index.html ~/Desktop/revenueforge-model.html
git add -A
git -c user.name="Lloyd Yip" -c user.email="accounting@quantum-scaling.com" commit -q -m "${1:-update} [build $STAMP]"
git push -q origin main
echo "pushed build $STAMP"
