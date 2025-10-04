#!/data/data/com.termux/files/usr/bin/bash

echo "🏗️ BUILDING VIRTUALANDRO NATIVE..."
echo "📱 Huawei Nova 4 - Kirin 970 Optimized"

# Clean previous builds
rm -rf build/classes build/libs
mkdir -p build/classes build/libs

# Compile all Java sources
echo "🔨 Compiling Java sources..."
find src/main/java -name "*.java" > sources.txt
javac -d build/classes @sources.txt

if [ $? -eq 0 ]; then
    echo "✅ Compilation successful"
    
    # Create executable JAR
    echo "📦 Creating JAR package..."
    jar cfe build/libs/VirtualAndroNative.jar com.virtualandro.core.VirtualAndro -C build/classes .
    
    # Make it executable
    chmod +x build/libs/VirtualAndroNative.jar
    
    echo "🎉 BUILD SUCCESSFUL!"
    echo "📍 JAR: build/libs/VirtualAndroNative.jar"
    echo "💾 Size: $(du -h build/libs/VirtualAndroNative.jar | cut -f1)"
else
    echo "❌ Compilation failed"
    exit 1
fi
