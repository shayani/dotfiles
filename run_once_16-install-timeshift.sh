#!/bin/bash

set -e

if [ -n "${XDG_CURRENT_DESKTOP}" ]; then
  echo ""
  echo "======================"
  echo "Installing Timeshift"
  echo "======================"

  sudo apt update && sudo apt install -y timeshift
fi
