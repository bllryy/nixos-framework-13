#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

detect_host() {
  local product
  product="$(cat /sys/class/dmi/id/product_name 2>/dev/null || true)"
  case "$product" in
    *Framework*|*Laptop\ 13*) echo "framework" ;;
    *) echo "desktop" ;;
  esac
}

HOST="${1:-}"
if [ -z "$HOST" ]; then
  HOST="$(detect_host)"
  echo "auto-detected host: $HOST"
fi

case "$HOST" in
  framework|desktop) ;;
  *) echo "unknown host: $HOST (expected: framework | desktop)"; exit 1 ;;
esac

HOST_DIR="$REPO_DIR/modules/hosts/$HOST"
HW_FILE="$HOST_DIR/hardware-configuration.nix"

if [ ! -d "$HOST_DIR" ]; then
  echo "missing host directory: $HOST_DIR"; exit 1
fi

if [ ! -f "$HW_FILE" ]; then
  echo "generating hardware-configuration.nix for $HOST"
  sudo nixos-generate-config --show-hardware-config > /tmp/hw-config.nix
  sudo mv /tmp/hw-config.nix "$HW_FILE"
  sudo chown "$USER:users" "$HW_FILE"
fi

sudo nixos-rebuild switch --flake "$REPO_DIR#$HOST"
