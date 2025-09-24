# Hyprland Hardware Keyboard Toggle

This repository contains scripts to toggle your hardware keyboard on and off in Hyprland.

## Files

- `keyboard_control.zsh`: This script is used to toggle the keyboard state.
- `keyboard_daemon.zsh`: This script likely runs in the background to monitor and apply keyboard settings.

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/ifnernalbits/exorcise-keys.git && cd exorcised-keys
    ```

2.  **Make scripts executable:**
    ```bash
    chmod +x keyboard_control.zsh
    chmod +x keyboard_daemon.zsh
    ```

3.  **Integrate with Hyprland:**
    You'll need to edit your Hyprland configuration file (usually `~/.config/hypr/hyprland.conf`) to include the daemon and control scripts, and to set up keybinds.

    **a. Start the daemon on Hyprland startup:**
    Add the following line to your `hyprland.conf` to ensure the daemon runs when Hyprland starts:
    ```conf
    exec-once = /path/to/repo/keyboard_daemon.zsh &
    ```

    **b. Bind a key to toggle the keyboard:**
    Add a keybinding to your `hyprland.conf` to execute the control script. For example, to toggle the keyboard with `Super + K`:
    ```conf
    # Toggle to enable keyboard with Super + K + E
    bind = $mainMod, K, E, exec, /path/to/repo/keyboard_control.zsh
    # Toggle to disable keyboard with Super + K + D
    bind = $mainMod, K, D, exec, /path/to/repo/keyboard_control.zsh
    ```
    (Note: `$mainMod` is typically the Super key, but check your `hyprland.conf` for its definition.)

## Usage

- Once configured in Hyprland, use your defined keybinding (e.g., `Super + K + E|D`) to toggle the hardware keyboard state.
- The `keyboard_daemon.zsh` script will run in the background to manage the keyboard state persistently.

## Customization

Edit `keyboard_control.zsh` and `keyboard_daemon.zsh` to adjust device names or specific Hyprland commands if necessary.
