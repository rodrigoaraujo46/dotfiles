#!/bin/sh

SYMLINK_NAME="igpu"
RULE_PATH="/etc/udev/rules.d/igpu-dev-path.rules"

# Find the PCI ID for the Intel iGPU
INTEL_IGPU_ID=$(lspci -D -d ::03xx | grep -i 'Intel' | cut -f1 -d' ')

# Check if an ID was actually found to prevent writing an empty rule
if [ -z "$INTEL_IGPU_ID" ]; then
	echo "Error: Intel iGPU not found via lspci."
	exit 1
fi

UDEV_RULE="$(
	cat <<EOF
KERNEL=="card*", \
KERNELS=="$INTEL_IGPU_ID", \
SUBSYSTEM=="drm", \
SUBSYSTEMS=="pci", \
SYMLINK+="dri/$SYMLINK_NAME"
EOF
)"

echo "$UDEV_RULE" | sudo tee "$RULE_PATH"
echo "Udev rule created at $RULE_PATH"

SYMLINK_NAME="dgpu"
RULE_PATH="/etc/udev/rules.d/dgpu-dev-path.rules"

# Find the PCI ID for the NVIDIA dGPU
# We use 'NVIDIA' and grab the first result
NVIDIA_DGPU_ID=$(lspci -D -d ::0300 | grep -i 'NVIDIA' | cut -f1 -d' ' | head -n1)

# Check if an ID was found
if [ -z "$NVIDIA_DGPU_ID" ]; then
	echo "Error: NVIDIA dGPU not found via lspci."
	exit 1
fi

UDEV_RULE="$(
	cat <<EOF
KERNEL=="card*", \
KERNELS=="$NVIDIA_DGPU_ID", \
SUBSYSTEM=="drm", \
SUBSYSTEMS=="pci", \
SYMLINK+="dri/$SYMLINK_NAME"
EOF
)"

echo "$UDEV_RULE" | sudo tee "$RULE_PATH"
echo "Udev rule created at $RULE_PATH"
