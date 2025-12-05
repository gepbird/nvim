#!/usr/bin/env bash
set -x

TARGET_SESSION=nvim
TARGET_WINDOW_NAME=edit

while true; do
  case "$1" in
  -n | --no-nix)
    NO_NIX=1
    shift
    ;;
  *)
    shift
    break
    ;;
  esac
done

nix_init() {
  if [[ $NO_NIX -ne 1 ]]; then
    evaled=$(nix eval --json --impure --expr "
      let
        flake = builtins.getFlake (toString ./.);
        system = builtins.currentSystem;
        dev = flake.packages.\${system}.dev;
      in
      {
        drv = dev.drvPath;
        config = dev.config.content;
      }
    ")
    nix-build "$(echo "$evaled" | jq --raw-output '.drv')" -o result-edit
    echo "$evaled" | jq --raw-output '.config' | sed 's/\\n/\n/g' >edit.lua
  fi
}

try_remove_edit_window() {
  EXISTING_WINDOW=$(tmux list-windows -t "$TARGET_SESSION" | grep "$TARGET_WINDOW_NAME")
  if [ -n "$EXISTING_WINDOW" ]; then
    tmux kill-window -t "$TARGET_SESSION:$TARGET_WINDOW_NAME"
  fi
}

init_window() {
  existing_indices=$(tmux list-windows -t $TARGET_SESSION -F "#{window_index}")
  for i in $(seq 0 99); do
    if ! echo "$existing_indices" | grep -q "^$i$"; then
      tmux new-window -t "$TARGET_SESSION:$i" -n "$TARGET_WINDOW_NAME"
      break
    fi
  done
}

cleanup() {
  try_remove_edit_window
  exit 0
}

setup_editing_nvim() {
  tmux select-window -t "$TARGET_SESSION:$TARGET_WINDOW"
  tmux send-keys -t "$TARGET_SESSION:$TARGET_WINDOW.0" "nvim edit.lua" c-m
}

start_testing_nvim() {
  tmux split-window -h -t "$TARGET_SESSION:$TARGET_WINDOW"
  tmux send-keys -t "$TARGET_SESSION:$TARGET_WINDOW.1" "$(cat testing-command)" c-m
}

auto_restart_testing_nvim() {
  while [[ -e edit.lua ]]; do
    start_testing_nvim
    inotifywait -e close_write edit.lua
    TESTING_PANE_PID=$(tmux list-panes -t "$TARGET_SESSION:$TARGET_WINDOW" -F '#{pane_pid}' | sed -n 2p)
    kill -9 "$TESTING_PANE_PID"
  done
}

nix_init

try_remove_edit_window
init_window

trap cleanup EXIT INT

setup_editing_nvim
auto_restart_testing_nvim
