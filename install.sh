#!/bin/bash
set -e

# Clone dotbot if not already there
if [ ! -d "dotbot" ]; then
  echo "Cloning Dotbot..."
  git clone https://github.com/anishathalye/dotbot.git --depth=1
fi

# Run Dotbot
./dotbot/bin/dotbot -c install.conf.yaml

