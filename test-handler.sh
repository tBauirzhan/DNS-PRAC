#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

while true; do
  clear
  echo "===== 🛰️ Remote Host Tester ====="
  echo "1. 🔍 Manual IP/Host Test"
  echo "2. 🧠 SSH Config Host Test"
  echo "3. 🔙 Back"
  echo "================================="
  read -rp "Choose option: " mode

  case "$mode" in
    1) bash "$SCRIPT_DIR/manual-test.sh" ;;
    2) bash "$SCRIPT_DIR/dns-test.sh" ;;
    3) break ;;
    *) echo "❗ Invalid choice"; sleep 1 ;;
  esac
done
