#!/data/data/com.termux/files/usr/bin/bash

VM_NAME=$1
ANDROID_VERSION=$2
VM_DIR="$HOME/VirtualAndroNative/vms/$VM_NAME"

echo "🔨 Creating Android $ANDROID_VERSION VM: $VM_NAME"
mkdir -p "$VM_DIR"

# Kirin 970 optimized QEMU parameters
case $ANDROID_VERSION in
    "11")
        MEMORY="1G"
        CORES="2"
        ;;
    "12") 
        MEMORY="1.5G"
        CORES="3"
        ;;
    "13")
        MEMORY="2G"
        CORES="4"
        ;;
    *)
        MEMORY="1G"
        CORES="2"
        ;;
esac

# Create VM start script
cat > "$VM_DIR/start.sh" << EOL
#!/data/data/com.termux/files/usr/bin/bash
echo "🚀 Starting $VM_NAME (Android $ANDROID_VERSION)"
echo "⚡ Kirin 970 Optimized - $MEMORY RAM, $CORES cores"

# QEMU command for Kirin 970
qemu-system-aarch64 \\
  -cpu cortex-a73 \\
  -smp $CORES \\
  -m $MEMORY \\
  -drive file=$VM_DIR/system.qcow2,if=virtio \\
  -netdev user,id=net0 -device virtio-net,netdev=net0 \\
  -display none \\
  -serial stdio \\
  -monitor telnet:localhost:1234,server,nowait
EOL

chmod +x "$VM_DIR/start.sh"

# Create VM configuration
cat > "$VM_DIR/vm.config" << EOL
name=$VM_NAME
android_version=$ANDROID_VERSION
memory=$MEMORY
cores=$CORES
created=$(date)
optimized_for_kirin970=true
EOL

echo "✅ VM created: $VM_DIR"
echo "📁 Config: $VM_DIR/vm.config"
echo "🚀 Start: $VM_DIR/start.sh"
