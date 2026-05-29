# How to add custom package to Lantronix OpenQ 6490 Qualcomm Lininux BSP with eSDK

This repository contains a simple test script package designed to demonstrate how to integrate custom software into the **Lantronix OpenQ Qualcomm Linux 6490 BSP** using the Extensible SDK (eSDK) and `devtool`. 

Find the steps below to set up your environment, inject this package, and include it in your final system image.

---

## 🛠️ Step 1: Install & Initialize the Lantronix eSDK

Before working with `devtool`, you must install and source the Lantronix extensible SDK on your Ubuntu host machine.

### 1. Extract the SDK Archive
Unzip the provided SDK package:
```bash
unzip sdk-<version>.zip
cd sdk
```
### 2. Extract the SDK Archive
Run the Installer
Execute the toolchain installation script:
```bash
./qcom-wayland-x86_64-qcom-multimedia-image-armv8-2a-qcs6490-openq-toolchain-extv1.2.sh
```
Note: You will be prompted to select an installation location on your host PC. The default path is ~/qcom-wayland_sdk, but you can customize this (e.g., /opt/qcom-wayland_sdk) depending on your environment preferences.

### 3. Source the eSDK Environment
Each time you wish to use the eSDK in a new shell session, you must to source the environment setup script to initialize the eSDK environment variables:
```bash
$ . <path to qcom-wayland_sdk>/environment-setup-armv8-2a-qcom-linux
or
$ cd <path to qcom-wayland_sdk>
$ source environment-setup-armv8-2a-qcom-linux
```
Verify that your terminal prompt changes or check that bitbake and devtool are now available in your $PATH.
```bash
$ devtool --help
```
