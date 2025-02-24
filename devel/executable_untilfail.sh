#!/bin/bash

count=0
export DISABLE_SPRING=1
export RUBY_DEBUG_OPEN=false

while "$@"; do
    ((count++))
    echo "Run #${count} completed successfully"
    echo "------------------------------------"
done

echo "Command failed after $count successful runs"
