#!/bin/bash

if tmux ls >/dev/null 2>&1; then
  tmux attach -t :
else
  tmux new-session
fi
