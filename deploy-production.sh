#!/data/data/com.termux/files/usr/bin/bash

echo "🎯 VIRTUALANDRO PRODUCTION DEPLOYMENT"
echo "📱 Huawei Nova 4 - Kirin 970 Optimized"

# Build final version
./build.sh

# Create system directories
mkdir -p ~/VirtualAndroNative/{vms,scripts,config,logs}

# Create desktop shortcut for Termux:Widget
mkdir -p ~/.shortcuts
cat > ~/.shortcuts/VirtualAndro << 'EOFSH'
#!/data/data/com.termux/files/usr/bin/bash
clear
echo "🚀 Starting VirtualAndro..."
cd ~/VirtualAndroNative
java -jar build/libs/VirtualAndroNative.jar
EOFSH

chmod +x ~/.shortcuts/VirtualAndro

# Create quick start alias
echo "alias virtualandro='cd ~/VirtualAndroNative && java -jar build/libs/VirtualAndroNative.jar'" >> ~/.bashrc

echo ""
echo "🎉 PRODUCTION DEPLOYMENT COMPLETE!"
echo "📍 Application: ~/VirtualAndroNative/build/libs/VirtualAndroNative.jar"
echo "🚀 Quick Start: virtualandro (after restarting Termux)"
echo "📱 Widget: Termux:Widget → VirtualAndro"
echo ""
echo "📊 SYSTEM STATUS:"
echo "   VMs Created: $(ls -1 vms/ 2>/dev/null | wc -l)"
echo "   Available RAM: $(free -m 2>/dev/null | grep Mem: | awk '{print $4}')MB"
echo "   Storage Free: $(df -h ~/ | tail -1 | awk '{print $4}')"
