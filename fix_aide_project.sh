#!/bin/bash
echo "Fixing AIDE project structure..."

# Ensure proper file permissions
find ~/VirtualAndroNative -name "*.java" -exec chmod 644 {} \;
find ~/VirtualAndroNative -name "*.xml" -exec chmod 644 {} \;

# Create AIDE project file
cat > ~/VirtualAndroNative/.aideproject << 'AIDE'
target=android-28
android.library=false
AIDE

echo "Project fixed. Reopen in AIDE."
