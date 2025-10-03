#!/bin/bash
echo "🔧 APPLYING LOCAL STORAGE FIXES"

# Create MainActivity.java with proper local storage
cat > app/src/main/java/com/virtualandro/MainActivity.java << 'JAVA_EOF'
package com.virtualandro;

import android.app.*;
import android.os.*;
import android.widget.*;
import android.view.*;
import android.util.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class MainActivity extends Activity {
    
    // Changed from /sdcard/VirtualAndro to local app storage
    private static final String VM_BASE = "VirtualAndro";
    private String vmDirectoryPath;
    private LinearLayout mainLayout;
    
    private String[] vmTemplates = {
        "Android 11 - Lightweight (2GB RAM)",
        "Android 12 - Balanced (3GB RAM)", 
        "Android 13 - Performance (4GB RAM)"
    };
    
    private String[] templateConfigs = {
        "ANDROID_VERSION=11\nALLOCATED_RAM=2048\nCPU_CORES=4\nSTORAGE=8192",
        "ANDROID_VERSION=12\nALLOCATED_RAM=3072\nCPU_CORES=6\nSTORAGE=12288", 
        "ANDROID_VERSION=13\nALLOCATED_RAM=4096\nCPU_CORES=8\nSTORAGE=16384"
    };
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Initialize VM directory path in local app storage
        vmDirectoryPath = getFilesDir().getAbsolutePath() + File.separator + VM_BASE;
        
        setupUI();
        createVMDirectory();
    }
    
    private void setupUI() {
        mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setPadding(50, 50, 50, 50);
        mainLayout.setBackgroundColor(0xFFF5F5F5);
        
        // Header
        addHeader();
        
        // VM Templates Section
        addTemplatesSection();
        
        // Hardware Info Section
        addHardwareInfo();
        
        // Storage Info
        addStorageInfo();
        
        setContentView(mainLayout);
    }
    
    private void addHeader() {
        TextView title = new TextView(this);
        title.setText("VirtualAndro");
        title.setTextSize(TypedValue.COMPLEX_UNIT_SP, 28);
        title.setGravity(Gravity.CENTER);
        title.setTextColor(0xFF2C3E50);
        title.setTypeface(null, Typeface.BOLD);
        
        TextView subtitle = new TextView(this);
        subtitle.setText("Android Virtualization Engine");
        subtitle.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
        subtitle.setGravity(Gravity.CENTER);
        subtitle.setTextColor(0xFF7F8C8D);
        
        mainLayout.addView(title);
        mainLayout.addView(subtitle);
        addSpace(30);
    }
    
    private void addTemplatesSection() {
        TextView sectionTitle = new TextView(this);
        sectionTitle.setText("Virtual Machine Templates");
        sectionTitle.setTextSize(TypedValue.COMPLEX_UNIT_SP, 20);
        sectionTitle.setTextColor(0xFF2C3E50);
        sectionTitle.setTypeface(null, Typeface.BOLD);
        mainLayout.addView(sectionTitle);
        addSpace(10);
        
        for (int i = 0; i < vmTemplates.length; i++) {
            addVMTemplateButton(i, vmTemplates[i]);
            if (i < vmTemplates.length - 1) addSpace(15);
        }
        addSpace(30);
    }
    
    private void addVMTemplateButton(final int index, String title) {
        Button btn = new Button(this);
        btn.setText(title);
        btn.setTextSize(TypedValue.COMPLEX_UNIT_SP, 14);
        btn.setBackgroundColor(0xFF3498DB);
        btn.setTextColor(0xFFFFFFFF);
        btn.setPadding(40, 30, 40, 30);
        
        // Make buttons full width
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        );
        btn.setLayoutParams(params);
        
        btn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                createVM(index + 11, templateConfigs[index]);
            }
        });
        
        mainLayout.addView(btn);
    }
    
    private void addHardwareInfo() {
        TextView hardwareTitle = new TextView(this);
        hardwareTitle.setText("Huawei Nova 4 - Hardware Optimized");
        hardwareTitle.setTextSize(TypedValue.COMPLEX_UNIT_SP, 18);
        hardwareTitle.setTextColor(0xFF2C3E50);
        hardwareTitle.setTypeface(null, Typeface.BOLD);
        mainLayout.addView(hardwareTitle);
        addSpace(10);
        
        TextView hardwareInfo = new TextView(this);
        hardwareInfo.setText("• Kirin 970 SoC (4x A73 + 4x A53)\n" +
                           "• Mali-G72 MP12 GPU\n" +
                           "• 8GB LPDDR4X RAM\n" +
                           "• 128GB UFS 2.1 Storage\n" +
                           "• Android 9 (EMUI 9.1)");
        hardwareInfo.setTextSize(TypedValue.COMPLEX_UNIT_SP, 14);
        hardwareInfo.setTextColor(0xFF34495E);
        hardwareInfo.setBackgroundColor(0xFFECF0F1);
        hardwareInfo.setPadding(30, 20, 30, 20);
        
        mainLayout.addView(hardwareInfo);
        addSpace(20);
    }
    
    private void addStorageInfo() {
        TextView storageInfo = new TextView(this);
        storageInfo.setText("📁 VM Storage: App Internal Storage\n" +
                          "📍 Path: " + vmDirectoryPath);
        storageInfo.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
        storageInfo.setTextColor(0xFF7F8C8D);
        storageInfo.setGravity(Gravity.CENTER);
        storageInfo.setPadding(20, 10, 20, 10);
        storageInfo.setBackgroundColor(0xFFF8F9FA);
        
        mainLayout.addView(storageInfo);
    }
    
    private void addSpace(int height) {
        View space = new View(this);
        space.setLayoutParams(new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, height));
        mainLayout.addView(space);
    }
    
    private void createVMDirectory() {
        File vmDir = new File(vmDirectoryPath);
        if (!vmDir.exists()) {
            boolean created = vmDir.mkdirs();
            if (created) {
                Log.d("VirtualAndro", "VM directory created: " + vmDirectoryPath);
            } else {
                Log.e("VirtualAndro", "Failed to create VM directory: " + vmDirectoryPath);
            }
        }
    }
    
    private void createVM(int androidVersion, String config) {
        String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String vmName = "android_" + androidVersion + "_" + timestamp;
        File vmDir = new File(vmDirectoryPath, vmName);
        
        if (vmDir.mkdirs()) {
            try {
                // Create detailed VM configuration
                File configFile = new File(vmDir, "vm_config.conf");
                FileWriter writer = new FileWriter(configFile);
                writer.write("# VirtualAndro VM Configuration\n");
                writer.write("VM_NAME=" + vmName + "\n");
                writer.write(config + "\n");
                writer.write("KIRIN_970_OPTIMIZED=true\n");
                writer.write("BIG_LITTLE_CONFIG=4xA53_cores_for_VM\n");
                writer.write("GPU_SHARING=Mali-G72_MP12_virtualized\n");
                writer.write("STORAGE_OPTIMIZED=UFS_2.1_compression\n");
                writer.write("STORAGE_PATH=" + vmDir.getAbsolutePath() + "\n");
                writer.write("CREATED=" + new Date() + "\n");
                writer.close();
                
                // Create startup script
                File startupScript = new File(vmDir, "start_vm.sh");
                FileWriter scriptWriter = new FileWriter(startupScript);
                scriptWriter.write("#!/system/bin/sh\n");
                scriptWriter.write("echo 'Starting Android " + androidVersion + " VM on Kirin 970'\n");
                scriptWriter.write("echo 'VM Location: " + vmDir.getAbsolutePath() + "'\n");
                scriptWriter.write("echo 'Allocated RAM: '$(grep ALLOCATED_RAM vm_config.conf | cut -d'=' -f2)'MB'\n");
                scriptWriter.write("echo 'CPU Cores: '$(grep CPU_CORES vm_config.conf | cut -d'=' -f2)\n");
                scriptWriter.close();
                
                // List created VMs
                listCreatedVMs();
                
                showSuccessMessage("✅ Created: " + vmName + "\nLocation: " + vmDir.getAbsolutePath());
                
            } catch (IOException e) {
                showErrorMessage("❌ Failed to create VM configuration: " + e.getMessage());
                Log.e("VirtualAndro", "VM creation error", e);
            }
        } else {
            showErrorMessage("❌ Failed to create VM directory: " + vmDir.getAbsolutePath());
        }
    }
    
    private void listCreatedVMs() {
        File vmBaseDir = new File(vmDirectoryPath);
        File[] vmDirs = vmBaseDir.listFiles();
        
        if (vmDirs != null && vmDirs.length > 0) {
            Log.d("VirtualAndro", "Found " + vmDirs.length + " VMs:");
            for (File vmDir : vmDirs) {
                if (vmDir.isDirectory()) {
                    Log.d("VirtualAndro", " - " + vmDir.getName());
                }
            }
        } else {
            Log.d("VirtualAndro", "No VMs found in " + vmDirectoryPath);
        }
    }
    
    private void showSuccessMessage(String message) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show();
        
        // Also show in a dialog for important info
        new AlertDialog.Builder(this)
            .setTitle("VM Created Successfully")
            .setMessage(message)
            .setPositiveButton("OK", null)
            .show();
    }
    
    private void showErrorMessage(String message) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }
}
JAVA_EOF

# Fix AndroidManifest.xml (remove permissions, fix package name)
cat > app/src/main/AndroidManifest.xml << 'XML_EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android" 
    package="com.virtualandro">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/AppTheme">

        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:label="@string/app_name">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
XML_EOF

echo "✅ Fixes applied!"
