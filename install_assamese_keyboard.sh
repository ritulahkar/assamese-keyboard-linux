#!/bin/bash

# Assamese as_ph Phonetic Keyboard Layout Installer
# This script automatically installs the Assamese phonetic keyboard layout

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root directly."
        print_status "Please run as a regular user. The script will use sudo when needed."
        exit 1
    fi
}

# Function to check if required commands exist
check_dependencies() {
    local deps=("sudo" "cp")
    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            print_error "Required command '$cmd' not found. Please install it first."
            exit 1
        fi
    done
}

# Function to backup existing files
backup_files() {
    local backup_dir="$HOME/.assamese-keyboard-backup-$(date +%Y%m%d-%H%M%S)"
    
    print_status "Creating backup directory: $backup_dir"
    mkdir -p "$backup_dir"
    
    # Backup evdev.xml if it exists
    if [[ -f "/usr/share/X11/xkb/rules/evdev.xml" ]]; then
        print_status "Backing up evdev.xml..."
        sudo cp "/usr/share/X11/xkb/rules/evdev.xml" "$backup_dir/evdev.xml.backup"
    fi
    
    # Backup existing as_ph file if it exists
    if [[ -f "/usr/share/X11/xkb/symbols/as_ph" ]]; then
        print_status "Backing up existing as_ph symbols file..."
        sudo cp "/usr/share/X11/xkb/symbols/as_ph" "$backup_dir/as_ph.backup"
    fi
    
    echo "$backup_dir" > "$HOME/.assamese-keyboard-last-backup"
    print_status "Backup completed in: $backup_dir"
}

# Function to setup repository directory
setup_repository() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    print_status "Working from repository directory: $script_dir"
    cd "$script_dir"
    
    # Check if as_ph file exists in the current directory
    if [[ ! -f "as_ph" ]]; then
        print_error "The 'as_ph' symbols file not found in the current directory."
        print_status "Please ensure you're running this script from the cloned repository directory."
        print_status "Expected file: $script_dir/as_ph"
        exit 1
    fi
    
    print_status "Found required files. Proceeding with installation..."
}

# Function to install symbols file
install_symbols_file() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    print_status "Installing as_ph symbols file..."
    
    # Check if XKB symbols directory exists
    if [[ ! -d "/usr/share/X11/xkb/symbols" ]]; then
        print_error "XKB symbols directory not found. Is X11 properly installed?"
        exit 1
    fi
    
    # Copy the symbols file
    sudo cp "$script_dir/as_ph" "/usr/share/X11/xkb/symbols/" || {
        print_error "Failed to copy symbols file. Check permissions."
        exit 1
    }
    
    print_status "Symbols file installed successfully."
}

# Function to update evdev.xml
update_evdev_xml() {
    local evdev_file="/usr/share/X11/xkb/rules/evdev.xml"
    
    print_status "Updating evdev.xml file..."
    
    # Check if evdev.xml exists
    if [[ ! -f "$evdev_file" ]]; then
        print_error "evdev.xml not found at $evdev_file"
        exit 1
    fi
    
    # Check if layout already exists
    if grep -q "<name>as_ph</name>" "$evdev_file"; then
        print_warning "Assamese layout already exists in evdev.xml. Skipping..."
        return 0
    fi
    
    # Create temporary file with the new layout entry
    local temp_file=$(mktemp)
    local layout_entry='    <layout>
      <configItem>
        <name>as_ph</name>
        <!-- Keyboard indicator for Assamese layouts -->
        <shortDescription>as</shortDescription>
        <description>Assamese (Phonetic)</description>
        <languageList>
          <iso639Id>asm</iso639Id>
        </languageList>
      </configItem>
    </layout>'
    
    # Insert the layout entry after <layoutList>
    awk -v layout="$layout_entry" '
    /<layoutList>/ {
        print $0
        print layout
        next
    }
    {print}
    ' "$evdev_file" > "$temp_file"
    
    # Replace the original file
    sudo cp "$temp_file" "$evdev_file" || {
        print_error "Failed to update evdev.xml"
        rm "$temp_file"
        exit 1
    }
    
    rm "$temp_file"
    print_status "evdev.xml updated successfully."
}

# Function to clear XKB cache
clear_xkb_cache() {
    print_status "Clearing XKB cache..."
    
    # Clear user XKB cache
    rm -rf "$HOME/.cache/xkb" 2>/dev/null || true
    
    # Clear system XKB cache if it exists
    sudo rm -rf "/var/lib/xkb" 2>/dev/null || true
    
    print_status "XKB cache cleared."
}

# Function to show completion message
show_completion_message() {
    echo
    print_status "=========================================="
    print_status "Assamese Keyboard Layout Installation Complete!"
    print_status "=========================================="
    echo
    print_status "Next steps:"
    echo "  1. Log out and log back in (or restart your session)"
    echo "  2. Go to your system's keyboard settings"
    echo "  3. Add 'Assamese (Phonetic)' from the list"
    echo "  4. Set it as your preferred input method"
    echo
    print_status "Repository location: $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    print_status "Backup location: $(cat $HOME/.assamese-keyboard-last-backup 2>/dev/null || echo 'Not available')"
    echo
    print_warning "If you encounter any issues, you can restore from the backup."
}

# Main installation function
main() {
    echo "============================================="
    echo "Assamese as_ph Phonetic Keyboard Installer"
    echo "============================================="
    echo
    
    # Perform checks
    print_status "Performing pre-installation checks..."
    check_root
    check_dependencies
    
    # Create backup
    backup_files
    
    # Setup repository
    setup_repository
    
    # Install components
    install_symbols_file
    update_evdev_xml
    
    # Clear cache
    clear_xkb_cache
    
    # Show completion message
    show_completion_message
}

# Handle script interruption
trap 'print_error "Installation interrupted. You may need to restore from backup."; exit 1' INT TERM

# Run main function
main "$@"