#!/bin/sh
echo "--- Device Software Version ---"
cat /etc/os-release

echo -e "\n--- Kernel Command Line ---"
cat /proc/cmdline
