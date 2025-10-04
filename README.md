# VirtualAndro Native

> Lightweight Android virtualization app specifically optimized for Huawei Nova 4 hardware

## 🚀 Features

- **Hardware-Optimized Virtualization**
  - Kirin 970 Big.LITTLE core management
  - Mali-G72 MP12 GPU sharing optimization
  - UFS 2.1 storage optimization
  - 8GB LPDDR4X RAM partitioning

- **Android VM Templates**
  - Android 11 (Lightweight - 1GB RAM)
  - Android 12 (Balanced - 1.5GB RAM)
  - Android 13 (Performance - 2GB RAM)

- **100% Android Native**
  - Built entirely on Huawei Nova 4
  - No desktop development tools required
  - Termux-native Java application

## 📋 Requirements

- Android device with Termux
- Huawei Nova 4 (Kirin 970 optimized)
- Java 17+ in Termux
- QEMU system aarch64

## ⚡ Quick Start

```bash
# Clone repository
git clone https://github.com/blackbutterfly313/VirtualAndro.git
cd VirtualAndro

# Build and run
./build.sh
virtualandro
