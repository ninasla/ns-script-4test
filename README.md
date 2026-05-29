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
Note: You will be prompted to select an installation location on your host PC. The default path is ~/qcom-wayland_sdk, but you can customize this depending on your environment preferences.

### 3. Source the eSDK Environment
Each time you wish to use the eSDK in a new shell session, you must to source the environment setup script to initialize the eSDK environment variables:
```bash
$ . <path to installed eSDK>/environment-setup-armv8-2a-qcom-linux
or
$ cd <path to installed eSDK>
$ source environment-setup-armv8-2a-qcom-linux
```
Verify that your terminal prompt changes or check that bitbake and devtool are now available in your $PATH.
```bash
$ devtool --help
```
## 📦 Step 2: Add and Build the Package with devtool

With the eSDK environment active, you can use `devtool` to automatically fetch this repository, create a recipe skeleton, and build it.

### 1. Add the Sample Package
Run the following command to create a new recipe named `ns-4test` pointing to this remote repository:
```bash
devtool add ns-4test [https://github.com/ninasla/ns-script-4test.git](https://github.com/ninasla/ns-script-4test.git)
```
This command automatically generates two key paths inside your eSDK directory structure:
- Recipe Template: <path to installed eSDK>/workspace/recipes/ns-4test/ns-4test_git.bb
- Source Workspace: <path to installed eSDK>/workspace/sources/ns-4test/

### 2. Configure the Recipe for Script Installation
Open the generated recipe file (ns-4test_git.bb) in your preferred text editor and append the following do_install block to instruct Yocto to install the script into the target's standard binary directory:
```bash
do_install () {
    # Specify install commands here
    install -d ${D}${bindir}
    install -m 0755 ${S}/ascript.sh ${D}${bindir}/ns-4test
}
```
### 3. Build the Package
Compile and package the recipe locally to verify there are no syntax or path issues:
```bash
devtool build ns-4test
```
## 🚀 Step 3: Deploy and Test on the OpenQ 6490 Target
You can live-test the package directly on your hardware without reflashing the entire system image.

### 1. Push to the Device
Use devtool to deploy the compiled binary directly over the network to your running target board:
```bash
devtool deploy-target ns-4test root@<target-device-IP>
```

### 2. Run the Test Script
Access your device via an ADB shell or SSH connection and execute the script:
```bash
# which ns-4test
/usr/bin/ns-4test

# ns-4test
```
Expected Output:
The script will execute and output system-specific details directly to the console:
```bash
--- Device Software Version ---devtool deploy-target ns-4test root@<target-device-IP>
[Version Info Output]

--- Kernel Command Line ---
[Kernel Boot Arguments Output]
```

### 3. Generate the Final IPK Package
Once verified on the target, generate the final package files:
```bash
devtool package ns-4test
```
This command generates a deployable standard Yocto .ipk package inside the eSDK build directory <path to installed eSDK>/tmp/deploy/ipk

**IPK** package could be transfered to target device over network using `adb push` or `scp` and installed using [Qualcomm Linux Native Package Manager (opkg)]
Qualcomm Linux includes opkg as its default, lightweight package manager on the target image. This allows you to install, update, and manage 'ipk packages directly on the live device without rebuilding the entire system image.
```bash
# opkg install /tmp/ns-4test_*.ipk
```
