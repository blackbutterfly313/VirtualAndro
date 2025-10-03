package com.virtualandro;

import android.app.*;
import android.os.*;
import android.widget.*;
import android.view.*;
import android.util.*;

public class MainActivity extends Activity {
    
    private LinearLayout mainLayout;
    
    private String[] vmTemplates = {
        "Android 11 - Lightweight (2GB RAM)",
        "Android 12 - Balanced (3GB RAM)", 
        "Android 13 - Performance (4GB RAM)"
    };
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setupUI();
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
        
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.WRAP_CONTENT
        );
        btn.setLayoutParams(params);
        
        btn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                createVM(index + 11);
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
    }
    
    private void addSpace(int height) {
        View space = new View(this);
        space.setLayoutParams(new LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT, height));
        mainLayout.addView(space);
    }
    
    private void createVM(int androidVersion) {
        String vmName = "Android " + androidVersion + " VM";
        showSuccessMessage("✅ Created: " + vmName + "\n(VM functionality coming soon)");
    }
    
    private void showSuccessMessage(String message) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show();
        
        new AlertDialog.Builder(this)
            .setTitle("VM Created Successfully")
            .setMessage(message)
            .setPositiveButton("OK", null)
            .show();
    }
}
