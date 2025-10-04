#!/bin/bash
echo "🔍 BUILD ENVIRONMENT DIAGNOSTIC"

echo "1. Java version:"
java -version 2>&1 | head -n 3

echo "2. Android SDK:"
ls -la $ANDROID_HOME/platforms/ 2>/dev/null | head -n 5 || echo "Android SDK not found"

echo "3. Build tools:"
ls -la $ANDROID_HOME/build-tools/ 2>/dev/null | head -n 5 || echo "Build tools not found"

echo "4. Project structure:"
find . -name "*.java" -o -name "AndroidManifest.xml" | head -n 10

echo "5. Available Android platforms:"
ls $ANDROID_HOME/platforms/ 2>/dev/null | grep android- || echo "No Android platforms found"

echo "6. Storage space:"
df -h | grep -E "(dm-5|/data)"
