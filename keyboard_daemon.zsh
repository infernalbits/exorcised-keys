#!/usr/bin/env zsh

# Path to the named pipe (FIFO) for communication
FIFO_PATH="/tmp/keyboard_toggle_fifo"

# Device name of the internal keyboard
KEYBOARD_DEVICE="AT Translated Set 2 keyboard"

# Log file for daemon activity
LOG_FILE="/tmp/keyboard_daemon.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Create the FIFO if it doesn't exist
if [[ ! -p "$FIFO_PATH" ]]; then
    mkfifo "$FIFO_PATH"
    log_message "Created FIFO: $FIFO_PATH"
fi

log_message "Daemon started. Listening for commands..."

# Loop indefinitely to read commands from the FIFO
while true; do
    if read -r command < "$FIFO_PATH"; then
        case "$command" in
            "enable")
                libinput set-prop "$KEYBOARD_DEVICE" "Device Enabled" 1
                if [[ $? -eq 0 ]]; then
                    log_message "Keyboard '$KEYBOARD_DEVICE' enabled."
                else
                    log_message "Error enabling keyboard '$KEYBOARD_DEVICE'."
                fi
                ;;
            "disable")
                libinput set-prop "$KEYBOARD_DEVICE" "Device Enabled" 0
                if [[ $? -eq 0 ]]; then
                    log_message "Keyboard '$KEYBOARD_DEVICE' disabled."
                else
                    log_message "Error disabling keyboard '$KEYBOARD_DEVICE'."
                fi
                ;;
            *)
                log_message "Received unknown command: '$command'"
                ;;
        esac
    else
        log_message "Error reading from FIFO. Recreating FIFO."
        rm -f "$FIFO_PATH"
        mkfifo "$FIFO_PATH"
    fi
done
