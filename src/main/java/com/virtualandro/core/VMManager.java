package com.virtualandro.core;

import java.io.*;
import java.util.*;

public class VMManager {
    private final String vmDirectory;
    
    public VMManager() {
        this.vmDirectory = System.getProperty("user.home") + "/VirtualAndroNative/vms";
        ensureVMDirectory();
    }
    
    private void ensureVMDirectory() {
        File dir = new File(vmDirectory);
        if (!dir.exists() && !dir.mkdirs()) {
            System.err.println("❌ Failed to create VM directory: " + vmDirectory);
        }
    }
    
    public void createVM(String vmName, String androidVersion) {
        System.out.println("🔨 Creating Android " + androidVersion + " VM: " + vmName);
        
        try {
            // Execute the VM creation script
            ProcessBuilder pb = new ProcessBuilder(
                "bash", "scripts/create-vm.sh", vmName, androidVersion
            );
            pb.directory(new File(System.getProperty("user.home") + "/VirtualAndroNative"));
            Process process = pb.start();
            
            // Read output
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }
            
            int exitCode = process.waitFor();
            if (exitCode == 0) {
                System.out.println("✅ VM creation completed: " + vmName);
            } else {
                System.out.println("❌ VM creation failed with exit code: " + exitCode);
            }
            
        } catch (Exception e) {
            System.err.println("❌ VM creation failed: " + e.getMessage());
        }
    }
    
    public List<String> listVMs() {
        List<String> vms = new ArrayList<>();
        File baseDir = new File(vmDirectory);
        File[] directories = baseDir.listFiles(File::isDirectory);
        
        if (directories != null) {
            for (File dir : directories) {
                // Read VM config to show details
                File config = new File(dir, "vm.config");
                if (config.exists()) {
                    try (BufferedReader reader = new BufferedReader(new FileReader(config))) {
                        String firstLine = reader.readLine();
                        String vmName = firstLine != null ? firstLine.split("=")[1] : dir.getName();
                        vms.add("📱 " + vmName + " (" + getVMConfig(dir, "android_version") + ")");
                    } catch (IOException e) {
                        vms.add("📁 " + dir.getName());
                    }
                } else {
                    vms.add("📁 " + dir.getName());
                }
            }
        }
        
        return vms;
    }
    
    private String getVMConfig(File vmDir, String key) {
        try (BufferedReader reader = new BufferedReader(new FileReader(new File(vmDir, "vm.config")))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.startsWith(key + "=")) {
                    return line.split("=")[1];
                }
            }
        } catch (IOException e) {
            // Ignore
        }
        return "unknown";
    }
}
