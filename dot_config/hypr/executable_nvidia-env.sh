#!/bin/bash
# Script to conditionally load NVIDIA configuration in Hyprland

# Check if NVIDIA GPU is present
if lspci | grep -i nvidia > /dev/null 2>&1; then
    echo "NVIDIA GPU detected, loading NVIDIA configuration..."

    # Use hyprctl keyword to set environment variables dynamically
    hyprctl keyword env LIBVA_DRIVER_NAME,nvidia
    hyprctl keyword env __GLX_VENDOR_LIBRARY_NAME,nvidia
    hyprctl keyword env NVD_BACKEND,direct

    echo "NVIDIA environment variables set successfully"
else
    echo "No NVIDIA GPU detected, skipping NVIDIA environment variables"
fi
