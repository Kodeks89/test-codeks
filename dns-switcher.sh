#!/bin/bash
# DNS switcher for systemd-resolved.
# Modes: cloudflare, google, default.

set -e

usage() {
    echo "Usage: $0 {cloudflare|google|default}" >&2
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi

MODE="$1"
CONF="/etc/systemd/resolved.conf"

apply_dns() {
    local dns="$1"
    if [ ! -w "$CONF" ]; then
        echo "This script requires root permissions." >&2
        exit 1
    fi
    # Remove existing DNS= lines and append new one if provided.
    sudo sed -i '/^DNS=/d' "$CONF"
    if [ -n "$dns" ]; then
        echo "DNS=$dns" | sudo tee -a "$CONF" >/dev/null
    fi
    sudo systemctl restart systemd-resolved
}

case "$MODE" in
    cloudflare)
        apply_dns "1.1.1.1 1.0.0.1"
        ;;
    google)
        apply_dns "8.8.8.8 8.8.4.4"
        ;;
    default)
        apply_dns ""
        ;;
    *)
        usage
        ;;
esac

echo "DNS switched to $MODE" 
