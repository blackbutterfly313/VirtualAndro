#!/data/data/com.termux/files/usr/bin/bash

cd ~/VirtualAndroNative

echo "🧪 TESTING VM CREATION..."
echo "1" > input.txt
echo "test-vm-1" >> input.txt
echo "1" >> input.txt
echo "5" >> input.txt

java -jar build/libs/VirtualAndroNative.jar < input.txt

rm input.txt

echo ""
echo "🔍 CHECKING VM CREATION RESULT..."
if [ -d "vms/test-vm-1" ]; then
    echo "✅ VM directory created successfully"
    ls -la vms/test-vm-1/
else
    echo "❌ VM directory not found"
fi
