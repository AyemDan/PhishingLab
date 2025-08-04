#!/bin/bash
# Test script to verify basic setup
# This file will be copied to each VM

echo "=== Phishing Lab Test Script ==="
echo "Hostname: $(hostname)"
echo "IP Address: $(hostname -I)"
echo "Date: $(date)"
echo ""

echo "=== Docker Status ==="
if command -v docker >/dev/null 2>&1; then
    echo "✓ Docker installed"
    sudo systemctl status docker --no-pager -l
else
    echo "✗ Docker not found"
fi

echo ""
echo "=== Desktop Environment ==="
if command -v startxfce4 >/dev/null 2>&1; then
    echo "✓ XFCE desktop environment installed"
else
    echo "✗ XFCE not found"
fi

echo ""
echo "=== Browsers ==="
if command -v firefox >/dev/null 2>&1; then
    echo "✓ Firefox installed"
else
    echo "✗ Firefox not found"
fi

if command -v chromium-browser >/dev/null 2>&1; then
    echo "✓ Chromium installed"
else
    echo "✗ Chromium not found"
fi

echo ""
echo "=== Remote Access ==="
if command -v xrdp >/dev/null 2>&1; then
    echo "✓ XRDP installed"
    sudo systemctl status xrdp --no-pager -l
else
    echo "✗ XRDP not found"
fi

echo ""
echo "=== File Locations ==="
if [ -d "/opt" ]; then
    echo "Contents of /opt:"
    ls -la /opt/
else
    echo "/opt directory not found"
fi

echo ""
echo "=== Test Complete ==="
