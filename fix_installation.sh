#!/bin/bash
echo "🔧 FIXING APK INSTALLATION ISSUES"

# Backup current manifest
cp app/src/main/AndroidManifest.xml app/src/main/AndroidManifest.xml.backup

# Create minimal working manifest
cat > app/src/main/AndroidManifest.xml << 'MANIFEST'
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

# Also update MainActivity.java to remove storage references
sed -i '/getFilesDir()/d' app/src/main/java/com/virtualandro/MainActivity.java
sed -i 's|vmDirectoryPath = getFilesDir().getAbsolutePath() + File.separator + VM_BASE;|vmDirectoryPath = "/data/data/com.virtualandro/files/VirtualAndro";|' app/src/main/java/com/virtualandro/MainActivity.java

echo "✅ Fixed installation issues:"
echo "   - Removed FileProvider (causing permission errors)"
echo "   - Using system default resources"
echo "   - Simplified storage path"
echo ""
echo "🚀 Now rebuild in AIDE and install with SYSTEM INSTALLER (not SAI)"
