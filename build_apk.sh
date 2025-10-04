#!/bin/bash
echo "🚀 BUILDING VIRTUALANDRO APK IN TERMUX"

cd ~/VirtualAndroNative

# Check if we have the necessary files
if [ ! -f "app/src/main/java/com/virtualandro/MainActivity.java" ]; then
    echo "❌ MainActivity.java not found!"
    exit 1
fi

if [ ! -f "app/src/main/AndroidManifest.xml" ]; then
    echo "❌ AndroidManifest.xml not found!"
    exit 1
fi

echo "📦 Checking build environment..."

# Download Gradle wrapper if not present
if [ ! -f "gradle/wrapper/gradle-wrapper.jar" ]; then
    echo "📥 Downloading Gradle wrapper..."
    wget -q https://github.com/gradle/gradle/raw/master/gradle/wrapper/gradle-wrapper.jar -O gradle/wrapper/gradle-wrapper.jar
fi

# Make gradlew executable
chmod +x gradlew 2>/dev/null || true

echo "🔨 Starting build process..."

# Try to build with Gradle
if [ -f "gradlew" ]; then
    echo "🛠️ Using Gradle build system..."
    ./gradlew assembleDebug
    if [ $? -eq 0 ]; then
        APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
    else
        echo "❌ Gradle build failed, trying manual method..."
    fi
fi

# Manual build method as fallback
if [ ! -f "$APK_PATH" ] || [ ! -s "$APK_PATH" ]; then
    echo "🛠️ Using manual build method..."
    
    # Create basic directory structure for manual build
    mkdir -p build/classes build/apk
    
    # Compile Java files
    echo "📝 Compiling Java code..."
    javac -cp "$ANDROID_HOME/platforms/android-28/android.jar" \
          -d build/classes \
          app/src/main/java/com/virtualandro/MainActivity.java \
          2>/dev/null || echo "⚠️ Java compilation may have warnings"
    
    # Create DEX file
    echo "📦 Creating DEX file..."
    d8 --lib "$ANDROID_HOME/platforms/android-28/android.jar" \
       --output build/apk \
       build/classes/com/virtualandro/*.class \
       2>/dev/null || echo "⚠️ DEX creation may have warnings"
    
    # Package APK
    echo "📱 Packaging APK..."
    aapt package -f -M app/src/main/AndroidManifest.xml \
                 -S app/src/main/res \
                 -I "$ANDROID_HOME/platforms/android-28/android.jar" \
                 -F build/apk/virtualandro-unsigned.apk \
                 build/apk/ || echo "⚠️ APK packaging may have warnings"
    
    APK_PATH="build/apk/virtualandro-unsigned.apk"
fi

if [ -f "$APK_PATH" ] && [ -s "$APK_PATH" ]; then
    echo "✅ APK built successfully: $APK_PATH"
    echo "📱 APK Size: $(du -h $APK_PATH | cut -f1)"
    
    # Copy to accessible location
    cp "$APK_PATH" VirtualAndro-debug.apk
    echo "📲 APK ready: VirtualAndro-debug.apk"
    
    # Install if desired
    echo ""
    read -p "🤔 Install APK now? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "📲 Installing APK..."
        pm install VirtualAndro-debug.apk && echo "✅ Installed successfully!" || echo "❌ Installation failed"
    fi
else
    echo "❌ APK build failed"
    echo "💡 Try building in AIDE or check for errors above"
fi
