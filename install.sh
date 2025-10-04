#!/data/data/com.termux/files/usr/bin/bash

echo "🎯 VirtualAndro Installer for Termux"
echo "📱 Optimized for Huawei Nova 4"

# Install dependencies
pkg update -y
pkg install -y openjdk-17 qemu-system-aarch64 git wget

# Clone repository
git clone https://github.com/blackbutterfly313/VirtualAndro.git
cd VirtualAndro

# Build application
chmod +x build.sh
./build.sh

# Create startup command
mkdir -p ~/.termux
echo "alias virtualandro='cd ~/VirtualAndro && java -jar build/libs/VirtualAndroNative.jar'" >> ~/.bashrc

echo ""
echo "🎉 Installation Complete!"
echo "🚀 Start with: virtualandro"
echo "💡 Restart Termux or run: source ~/.bashrc"
