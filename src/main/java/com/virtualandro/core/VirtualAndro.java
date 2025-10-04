package com.virtualandro.core;

public class VirtualAndro {
    public static void main(String[] args) {
        System.out.println("🚀 VirtualAndro Native v1.0");
        System.out.println("📱 Huawei Nova 4 - Kirin 970 Optimized");
        System.out.println("💾 Memory: " + Runtime.getRuntime().maxMemory() / (1024 * 1024) + "MB available");
        
        displayHardwareInfo();
        
        VMManager vmManager = new VMManager();
        MenuSystem menu = new MenuSystem(vmManager);
        
        if (args.length == 0) {
            menu.displayMainMenu();
        } else {
            handleCommandLine(args, vmManager);
        }
    }
    
    private static void displayHardwareInfo() {
        Runtime runtime = Runtime.getRuntime();
        int processors = runtime.availableProcessors();
        
        System.out.println("⚡ Processors: " + processors + " cores (Kirin 970 Big.LITTLE)");
        System.out.println("🔧 Java: " + System.getProperty("java.version"));
        System.out.println("📊 Free Memory: " + runtime.freeMemory() / (1024 * 1024) + "MB");
        
        if (processors == 8) {
            System.out.println("✅ Kirin 970 Octa-core detected - Optimization active");
        }
    }
    
    private static void handleCommandLine(String[] args, VMManager vmManager) {
        switch (args[0]) {
            case "--list":
                System.out.println("📋 Available VMs:");
                vmManager.listVMs().forEach(System.out::println);
                break;
            case "--create":
                if (args.length >= 3) {
                    vmManager.createVM(args[1], args[2]);
                } else {
                    System.out.println("❌ Usage: --create <vm-name> <android-version>");
                }
                break;
            default:
                System.out.println("❓ Unknown command: " + args[0]);
        }
    }
}
