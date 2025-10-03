#!/bin/bash
echo "🚀 AUTOMATED GITHUB DEPLOYMENT"

cd ~/VirtualAndroNative

# Check if there are changes to commit
if git diff --quiet && git diff --staged --quiet; then
    echo "✅ No changes to commit"
    exit 0
fi

echo "📦 Staging changes..."
git add .

echo "💾 Creating commit..."
git commit -m "🔧 Update: $(date +'%Y-%m-%d %H:%M:%S')

- Automated deployment from Huawei Nova 4
- Built with Termux + AIDE
- VirtualAndro development progress

Device: Huawei Nova 4 (Kirin 970)
Developer: blackbutterfly313"

echo "🌐 Pushing to GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo "✅ Successfully deployed to GitHub!"
    echo "📱 Repository: https://github.com/blackbutterfly313/VirtualAndro"
    echo "📊 Latest commit:"
    git log --oneline -1
else
    echo "❌ Push failed. Check your connection and try:"
    echo "   git push origin main"
fi
