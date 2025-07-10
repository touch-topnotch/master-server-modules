#!/usr/bin/env bash
set -euo pipefail

# Configuration
TUNNELS=(
  "8080:localhost:8080"
  "8160:localhost:8160"
  "8240:localhost:8240"
)
SSH_USER="kirill"
SSH_HOST="89.169.36.93"
SSH_PORT="3333"
# Path to SSH private key (ensure key-based auth is set up on the server)
SSH_KEY="${HOME}/.ssh/id_rsa"

# Ensure autossh is installed
if ! command -v autossh &>/dev/null; then
  echo "ERROR: autossh not found. Please install it." >&2
  exit 1
fi

# Function to check if a local port is already listening
check_tunnel() {
  local port="$1"
  ss -tnlp 2>/dev/null | grep -q ":${port} "
}

for tunnel in "${TUNNELS[@]}"; do
  LOCAL_PORT="${tunnel%%:*}"

  if check_tunnel "${LOCAL_PORT}"; then
    echo "[SKIP] Tunnel on port ${LOCAL_PORT} is already running."
  else
    echo "[START] Launching SSH tunnel ${tunnel}..."
    if autossh -M 0 \
        -f -N \
        -o ExitOnForwardFailure=yes \
        -o ServerAliveInterval=30 \
        -o ServerAliveCountMax=3 \
        -i "${SSH_KEY}" \
        -p "${SSH_PORT}" \
        -L "${tunnel}" \
        "${SSH_USER}@${SSH_HOST}"; then
      echo "[OK] Tunnel ${LOCAL_PORT} started successfully."
    else
      echo "[ERROR] Failed to start tunnel on port ${LOCAL_PORT}." >&2
    fi
  fi

done
