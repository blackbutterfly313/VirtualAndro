package com.virtualandro.core;

import java.io.*;

public class VMStarter {
    
    public static void startVM(String vmName) {
        String startScript = System.getProperty("user.home") + 
                           "/VirtualAndroNative/vms/" + vmName + "/start.sh";
        
        File script = new File(startScript);
        if (!script.exists()) {
            System.out.println("❌ VM not found: " + vmName);
            return;
        }
        
        System.out.println("🚀 Starting VM: " + vmName);
        System.out.println("⚠️  This will start QEMU in the background...");
        
        try {
            ProcessBuilder pb = new ProcessBuilder("bash", startScript);
            pb.directory(new File(System.getProperty("user.home") + "/VirtualAndroNative"));
            Process process = pb.start();
            
            // Monitor process for a few seconds
            Thread monitor = new Thread(() -> {
                try {
                    Thread.sleep(3000);
                    if (process.isAlive()) {
                        System.out.println("✅ VM started successfully");
                        System.out.println("📡 Connect via: telnet localhost 1234");
                    }
                } catch (Exception e) {
                    System.err.println("❌ VM startup monitoring failed");
                }
            });
            monitor.start();
            
        } catch (IOException e) {
            System.err.println("❌ Failed to start VM: " + e.getMessage());
        }
    }
    
    public static void stopVM(String vmName) {
        System.out.println("🛑 Stopping VM: " + vmName);
        try {
            // Send shutdown command via QEMU monitor
            ProcessBuilder pb = new ProcessBuilder(
                "echo", "system_powerdown", "|", "telnet", "localhost", "1234"
            );
            Process process = pb.start();
            process.waitFor();
            System.out.println("✅ VM shutdown command sent");
        } catch (Exception e) {
            System.err.println("❌ Failed to stop VM: " + e.getMessage());
        }
    }
}
