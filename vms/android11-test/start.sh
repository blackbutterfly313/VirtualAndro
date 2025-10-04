#!/data/data/com.termux/files/usr/bin/bash
echo "🚀 Starting android11-test (Android 11)"
echo "⚡ Kirin 970 Optimized - 1G RAM, 2 cores"

# QEMU command for Kirin 970
qemu-system-aarch64 \
  -cpu cortex-a73 \
  -smp 2 \
  -m 1G \
  -drive file=/data/data/com.termux/files/home/VirtualAndroNative/vms/android11-test/system.qcow2,if=virtio \
  -netdev user,id=net0 -device virtio-net,netdev=net0 \
  -display none \
  -serial stdio \
  -monitor telnet:localhost:1234,server,nowait
