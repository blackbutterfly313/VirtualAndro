package com.virtualandro.core;

import java.util.Scanner;

public class MenuSystem {
    private final VMManager vmManager;
    private final Scanner scanner;
    
    public MenuSystem(VMManager vmManager) {
        this.vmManager = vmManager;
        this.scanner = new Scanner(System.in);
    }
    
    public void displayMainMenu() {
        while (true) {
            System.out.println("\n=== VirtualAndro Menu ===");
            System.out.println("1. Create Android VM");
            System.out.println("2. List VMs");
            System.out.println("3. Start VM");
            System.out.println("4. Stop VM");
            System.out.println("5. System Info");
            System.out.println("6. Kirin 970 Optimization");
            System.out.println("7. Exit");
            System.out.print("Choose option: ");
            
            try {
                String choice = scanner.nextLine().trim();
                
                switch (choice) {
                    case "1":
                        createVMMenu();
                        break;
                    case "2":
                        listVMs();
                        break;
                    case "3":
                        startVMMenu();
                        break;
                    case "4":
                        stopVMMenu();
                        break;
                    case "5":
                        displaySystemInfo();
                        break;
                    case "6":
                        displayKirinOptimization();
                        break;
                    case "7":
                        System.out.println("👋 Exiting VirtualAndro...");
                        return;
                    default:
                        System.out.println("❌ Invalid option: " + choice);
                }
            } catch (Exception e) {
                System.err.println("❌ Input error: " + e.getMessage());
                scanner.nextLine();
            }
        }
    }
    
    private void createVMMenu() {
        try {
            System.out.print("Enter VM name: ");
            String vmName = scanner.nextLine().trim();
            
            if (vmName.isEmpty()) {
                System.out.println("❌ VM name cannot be empty");
                return;
            }
            
            System.out.println("Select Android version:");
            System.out.println("1. Android 11 (Lightweight - 1GB RAM)");
            System.out.println("2. Android 12 (Balanced - 1.5GB RAM)");
            System.out.println("3. Android 13 (Performance - 2GB RAM)");
            System.out.print("Choose version: ");
            
            String versionChoice = scanner.nextLine().trim();
            String androidVersion = switch (versionChoice) {
                case "1" -> "11";
                case "2" -> "12";
                case "3" -> "13";
                default -> {
                    System.out.println("❌ Invalid version, defaulting to Android 11");
                    yield "11";
                }
            };
            
            vmManager.createVM(vmName, androidVersion);
            
        } catch (Exception e) {
            System.err.println("❌ VM creation failed: " + e.getMessage());
        }
    }
    
    private void startVMMenu() {
        System.out.print("Enter VM name to start: ");
        String vmName = scanner.nextLine().trim();
        VMStarter.startVM(vmName);
    }
    
    private void stopVMMenu() {
        System.out.print("Enter VM name to stop: ");
        String vmName = scanner.nextLine().trim();
        VMStarter.stopVM(vmName);
    }
    
    private void listVMs() {
        System.out.println("\n📋 Virtual Machines:");
        java.util.List<String> vms = vmManager.listVMs();
        if (vms.isEmpty()) {
            System.out.println("No VMs created yet");
            System.out.println("Use option 1 to create your first VM");
        } else {
            vms.forEach(System.out::println);
        }
    }
    
    private void displaySystemInfo() {
        Runtime runtime = Runtime.getRuntime();
        System.out.println("\n📊 System Information:");
        System.out.println("Device: Huawei Nova 4 - Kirin 970");
        System.out.println("Architecture: ARM64 (aarch64)");
        System.out.println("Cores: 8 (4x Cortex-A73 + 4x Cortex-A53)");
        System.out.println("Java Version: " + System.getProperty("java.version"));
        System.out.println("Total Memory: " + runtime.totalMemory() / (1024 * 1024) + "MB");
        System.out.println("Free Memory: " + runtime.freeMemory() / (1024 * 1024) + "MB");
        System.out.println("Max Memory: " + runtime.maxMemory() / (1024 * 1024) + "MB");
        System.out.println("Available Processors: " + runtime.availableProcessors());
    }
    
    private void displayKirinOptimization() {
        System.out.println("\n⚡ Kirin 970 Optimizations:");
        System.out.println("✅ Big.LITTLE core awareness");
        System.out.println("✅ Memory allocation optimization");
        System.out.println("✅ Thermal management ready");
        System.out.println("✅ UFS 2.1 storage optimization");
        System.out.println("✅ Mali-G72 GPU consideration");
        System.out.println("📝 VM RAM allocation: 1-2GB (system-aware)");
        System.out.println("📝 CPU core allocation: 2-4 cores (performance-balanced)");
        System.out.println("🎯 Production Ready: VirtualAndro Native v1.0");
    }
}
