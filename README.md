# assamese-keyboard-linux

Free Assamese keyboard layout for Linux

## Example of the Assamese as_ph Phenotypic Layout

![image](/img/as_ph_layout_pic.png)

## Installation

You can install the Assamese `as_ph` (phenotypic) keyboard layout using either the automated installer script or manual installation.

### Option 1: Automated Installation (Recommended)

The easiest way to install the layout is using our automated installer script:

#### 1. Clone the Repository
```bash
git clone https://github.com/ritulahkar/assamese-keyboard-linux.git
cd assamese-keyboard-linux
```

#### 2. Run the Installer
```bash
chmod +x install_assamese_keyboard.sh
./install_assamese_keyboard.sh
```

The script will:
- Create automatic backups of your system files
- Install the `as_ph` symbols file
- Update the system configuration
- Clear XKB cache for immediate effect

#### 3. Activate the Layout
After the script completes:
1. Log out and log back in (or restart your session)
2. Go to your system's keyboard settings
3. Add "Assamese (Phonetic)" from the available layouts
4. Set it as your preferred input method

### Option 2: Manual Installation

If you prefer to install manually, follow these detailed steps:

#### 1. Clone the GitHub Repository
First, clone this repository to your local machine:
```bash
git clone https://github.com/ritulahkar/assamese-keyboard-linux.git
cd assamese-keyboard-linux
```

#### 2. Copy the `as_ph` Symbols File
Next, you need to copy the `as_ph` symbols file to the XKB directory on your system:
```bash
sudo cp as_ph /usr/share/X11/xkb/symbols/
```

#### 3. Update the EVDEV XML File
Now, edit the `evdev.xml` file to add your layout to the list of available layouts.

- Open the `evdev.xml` file:
```bash
sudo nano /usr/share/X11/xkb/rules/evdev.xml
```

- Search for the `<layoutList>` section. Just below the `<layoutList>` tag, within this section, add the following block:
```xml
<layout>
  <configItem>
    <name>as_ph</name>
    <!-- Keyboard indicator for Assamese layouts -->
    <shortDescription>as</shortDescription>
    <description>Assamese (Phonetic)</description>
    <languageList>
      <iso639Id>asm</iso639Id>
    </languageList>
  </configItem>
</layout>
```

After this you will have to select the layout in the keyboard settings.

#### 4. Apply Changes and Set the Layout
After updating the XML file, you can now apply the new layout using:
```bash
setxkbmap as_ph
```

To make this layout persistent across reboots, follow the next step.

#### 5. Set as Default (Optional)
If you want to set this layout as your default Assamese layout:

- Open the keyboard configuration file:
```bash
sudo nano /etc/default/keyboard
```

- Look for the line that starts with `XKBLAYOUT` and add `as_ph`:
```bash
XKBLAYOUT="us,as_ph"
```

- Save and close the file, then restart your computer or apply the changes using:
```bash
sudo dpkg-reconfigure keyboard-configuration
```

#### 6. Verify the Installation
You can verify the new layout by switching to it using your system's keyboard settings, or you can use the following command to test:
```bash
setxkbmap as_ph
```

## Setting Up Dual Layout (Linux Mint Example)

After installation, you can set up a dual layout system to easily switch between English and Assamese. Here's how to do it in Linux Mint:

### Method 1: Using System Settings (GUI)

1. **Open Keyboard Settings**:
   - Go to `Menu` → `System Settings` → `Keyboard`
   - Click on the `Layouts` tab

2. **Add Multiple Layouts**:
   - Click the `+` (Add) button
   - First, ensure "English (US)" is in the list
   - Click `+` again to add "Assamese (Phonetic)"
   - You should now see both layouts listed

3. **Configure Layout Switching**:
   - In the same Keyboard settings window, look for "Options" or "Advanced"
   - Find "Switching to another layout" section
   - Select your preferred key combination (commonly `Alt+Shift` or `Ctrl+Space`)

4. **Apply and Test**:
   - Click "Apply" or "OK"
   - Test switching by pressing your chosen key combination
   - You should see a layout indicator in your system tray

### Method 2: Using Command Line

You can also set up dual layout using the terminal:

```bash
# Set up dual layout with Alt+Shift toggle
setxkbmap -layout us,as_ph -option grp:alt_shift_toggle

# Alternative: Use Ctrl+Space toggle
setxkbmap -layout us,as_ph -option grp:ctrl_space_toggle

# Alternative: Use Caps Lock toggle
setxkbmap -layout us,as_ph -option grp:caps_toggle
```

### Method 3: Making It Permanent

To make the dual layout setup permanent across reboots:

1. **Create a startup script**:
```bash
mkdir -p ~/.config/autostart
nano ~/.config/autostart/keyboard-layout.desktop
```

2. **Add the following content**:
```ini
[Desktop Entry]
Type=Application
Name=Keyboard Layout Setup
Exec=setxkbmap -layout us,as_ph -option grp:alt_shift_toggle
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
```

3. **Make it executable**:
```bash
chmod +x ~/.config/autostart/keyboard-layout.desktop
```

### Layout Indicator

Most desktop environments will show a layout indicator (like "US" or "AS") in the system tray. If you don't see it:

- **For Cinnamon (Linux Mint default)**:
  - Right-click on the panel → `Add applets to the panel`
  - Search for "Keyboard" and add the "Keyboard Layout" applet

- **For other desktop environments**, look for keyboard layout widgets or indicators in their respective settings.

## Quick Commands

Once installed, you can use these commands to switch layouts:

```bash
# Switch to Assamese layout only
setxkbmap as_ph

# Switch back to US layout only
setxkbmap us

# Set up dual layout with Alt+Shift toggle
setxkbmap -layout us,as_ph -option grp:alt_shift_toggle

# Clear all options and reset to default
setxkbmap -option

# Check current layout
setxkbmap -query
```

## Troubleshooting

### If the automated installer fails:
- Check if you have the required permissions (the script will ask for sudo when needed)
- Ensure you're running the script from the cloned repository directory
- Check the backup files created by the script if you need to restore

### If manual installation doesn't work:
- Verify that the XKB directory exists: `/usr/share/X11/xkb/symbols/`
- Check that you have write permissions (use `sudo` for system files)
- Clear XKB cache: `rm -rf ~/.cache/xkb`
- Restart your desktop session after making changes

### Common Issues:
- **Layout not appearing in settings**: Make sure you've logged out and back in after installation
- **Layout not working**: Verify the `as_ph` file exists in `/usr/share/X11/xkb/symbols/`
- **Changes not persistent**: Follow the dual layout setup instructions or step 5 in manual installation
- **Layout indicator not showing**: Add keyboard layout applet to your panel (see dual layout section)
- **Can't switch between layouts**: Ensure you've set up the toggle key combination properly

## Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.