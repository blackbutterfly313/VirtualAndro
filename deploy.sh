#!/data/data/com.termux/files/usr/bin/bash

echo "🎯 VIRTUALANDRO DEPLOYMENT PACKAGE"
echo "📱 Huawei Nova 4 - Kirin 970 Optimized"

# Check dependencies
echo "🔍 Checking dependencies..."
for pkg in java javac jar qemu-system-aarch64; do
    if command -v $pkg >/dev/null 2>&1; then
        echo "✅ $pkg installed"
    else
        echo "❌ $pkg missing - installing..."
        pkg install -y $(pkg search $pkg | grep -o '^[^/]*' | head -1)
    fi
done

# Build the application
echo "🏗️ Building VirtualAndro..."
./build.sh

# Create desktop shortcut
cat > ~/.shortcuts/VirtualAndro << 'EOFSH'
#!/data/data/com.termux/files/usr/bin/bash
cd ~/VirtualAndroNative
java -jar build/libs/VirtualAndroNative.jar
EOFSH

chmod +x ~/.shortcuts/VirtualAndro

echo ""
echo "🎉 DEPLOYMENT COMPLETE!"
echo "📍 Application: ~/VirtualAndroNative/build/libs/VirtualAndroNative.jar"
echo "🚀 Quick Start: ~/.shortcuts/VirtualAndro"
echo "💡 Run: cd ~/VirtualAndroNative && java -jar build/libs/VirtualAndroNative.jar"
