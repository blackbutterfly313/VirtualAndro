#!/bin/bash
echo "🛠️ SIMPLE APK BUILD FOR VIRTUALANDRO"

cd ~/VirtualAndroNative

# Create build directories
mkdir -p build/{classes,dex,apk}

echo "📝 Step 1: Compile Java to class files..."
javac -cp "$ANDROID_HOME/platforms/android-28/android.jar" \
      -d build/classes \
      app/src/main/java/com/virtualandro/*.java

echo "📦 Step 2: Convert to DEX format..."
d8 --lib "$ANDROID_HOME/platforms/android-28/android.jar" \
   --min-api 21 \
   build/classes/com/virtualandro/*.class \
   --output build/dex

echo "📱 Step 3: Create AndroidManifest.xml..."
cat > AndroidManifest_simple.xml << 'MANIFEST'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.virtualandro">

    <application
        android:allowBackup="true"
        android:icon="@android:drawable/sym_def_app_icon"
        android:label="VirtualAndro"
        android:theme="@android:style/Theme.Light">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:label="VirtualAndro">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
MANIFEST

echo "🎁 Step 4: Package APK..."
aapt package -f -M AndroidManifest_simple.xml \
             -S app/src/main/res \
             -I "$ANDROID_HOME/platforms/android-28/android.jar" \
             -F build/apk/unsigned.apk \
             build/dex

echo "🔐 Step 5: Sign APK (using debug key)..."
# Generate debug key if not exists
if [ ! -f debug.keystore ]; then
    keytool -genkey -v -keystore debug.keystore \
            -alias androiddebugkey -keyalg RSA \
            -keysize 2048 -validity 10000 \
            -dname "CN=Android Debug,O=Android,C=US" \
            -storepass android -keypass android
fi

# Sign APK
apksigner sign --ks debug.keystore \
               --ks-pass pass:android \
               --key-pass pass:android \
               --out VirtualAndro-signed.apk \
               build/apk/unsigned.apk

if [ -f "VirtualAndro-signed.apk" ]; then
    echo "✅ SUCCESS: APK built and signed!"
    echo "📱 File: VirtualAndro-signed.apk"
    echo "📊 Size: $(du -h VirtualAndro-signed.apk | cut -f1)"
    
    # Install directly
    echo ""
    echo "📲 Installing..."
    pm install VirtualAndro-signed.apk && echo "🎉 Installed successfully!" || echo "❌ Install failed - try manual install"
else
    echo "❌ Build failed"
fi
