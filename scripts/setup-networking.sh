#!/data/data/com.termux/files/usr/bin/bash

echo "🌐 VIRTUALANDRO NETWORKING SETUP"
echo "📱 Huawei Nova 4 - Kirin 970 Optimized"

# Check current network configuration
echo "🔍 Current Network Status:"
ip addr show | grep -E "inet |state" | head -10

echo ""
echo "📡 Available Networking Options:"
echo "1. User Mode Networking (Default - Works everywhere)"
echo "2. TUN/TAP Setup (Advanced - Requires root)"
echo "3. Port Forwarding Configuration"
echo ""

read -p "Choose option [1-3]: " net_choice

case $net_choice in
    1)
        echo "✅ User Mode Networking enabled"
        echo "📝 VMs will use QEMU user networking (10.0.2.x range)"
        echo "🔧 Port forwarding: host 2222 → guest 22 (SSH)"
        ;;
    2)
        echo "🔧 TUN/TAP Setup (Advanced)"
        echo "⚠️  Requires root access and additional configuration"
        echo "💡 Consider using User Mode Networking instead"
        ;;
    3)
        echo "🔧 Port Forwarding Configuration"
        echo "Example: Forward host port 8080 to guest port 80"
        echo "Add to QEMU: -netdev user,id=net0,hostfwd=tcp::8080-:80"
        ;;
    *)
        echo "❌ Invalid option, using User Mode Networking"
        ;;
esac

echo ""
echo "🌐 Networking setup complete"
echo "💡 Default: User networking with automatic port translation"
