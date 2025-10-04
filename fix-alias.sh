#!/data/data/com.termux/files/usr/bin/bash

echo "🔧 FIXING VIRTUALANDRO ALIAS..."

# Remove existing alias if any
sed -i '/alias virtualandro/d' ~/.bashrc

# Add alias with proper path
echo "alias virtualandro='cd /data/data/com.termux/files/home/VirtualAndroNative && java -jar build/libs/VirtualAndroNative.jar'" >> ~/.bashrc

# Reload configuration
source ~/.bashrc

echo "✅ Alias fixed. Test with: virtualandro"
