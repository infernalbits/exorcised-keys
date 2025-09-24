#!/usr/bin/env zsh

# Path to the named pipe (FIFO) for communication
FIFO_PATH="/tmp/keyboard_toggle_fifo"

# Check if a command (enable/disable) is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 [enable|disable]"
    exit 1
fi

COMMAND="$1"

# Validate the command
if [[ "$COMMAND" != "enable" && "$COMMAND" != "disable" ]]; then
    echo "Invalid command: $COMMAND. Use 'enable' or 'disable'."
    exit 1
fi

# Check if the FIFO exists
if [[ ! -p "$FIFO_PATH" ]]; then
    echo "Error: Daemon not running or FIFO not found at $FIFO_PATH."
    echo "Please start the daemon first: /home/redd/Development/keyboard_toggle/keyboard_daemon.zsh &"
    exit 1
fi

# Send the command to the daemon via the FIFO
echo "$COMMAND" > "$FIFO_PATH"

echo "Sent command: $COMMAND to keyboard daemon."
