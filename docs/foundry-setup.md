# Foundry VTT Setup (Optional)

This file documents how to manually set up Foundry VTT on systems where it will be used.

---

## Installation

1. Download Foundry VTT from the [official website](https://foundryvtt.com/)

2. Extract the downloaded archive to your home folder (or any preferred location):
   
   ```bash
   tar -xvf FoundryVTT-12.331.zip -C ~/
   ```

3. Optional: Rename the folder for clarity:
   
   ```bash
   mv ~/FoundryVTT-12.331 ~/FoundryVTT
   ```

---

## Permissions Fix (Chrome Sandbox)

To allow Foundry to launch properly with sandboxing, you must set ownership and permissions on the bundled `chrome-sandbox` binary:

```bash
sudo chown root:root ~/FoundryVTT/chrome-sandbox
sudo chmod 4755 ~/FoundryVTT/chrome-sandbox
```

This ensures Chromium's sandbox can run with the appropriate privileges.

---

## Create a Desktop Launcher

To launch Foundry like a normal app, create a `.desktop` file:

```bash
nano ~/.local/share/applications/foundryvtt.desktop
```

Paste in the following (adjust paths if needed):

```ini
[Desktop Entry]
Name=Foundry VTT
Comment=Launch Foundry Virtual Tabletop
Exec=/home/USERNAME/FoundryVTT/foundryvtt
Icon=/home/USERNAME/FoundryVTT/FoundryLogo.webp
Terminal=false
Type=Application
Categories=Game;Utility;
StartupWMClass=foundryvtt
```

Note: a copy of the Foundry logo icon is stored in the repo under ~/config-files/docs/assets/FoundryLogo.webp. Copy the file from the repo to /home/USERNAME/FoundryVTT. 

Then run:

```bash
chmod +x ~/.local/share/applications/foundryvtt.desktop
```

> 📌 **Note**: PNG icons are more widely supported than `.webp` in desktop environments. 

---

## Final Notes

- You can now search for "Foundry VTT" in your launcher and pin it to your dock or favorites.
- This setup is **not included** in the main config-files repo or automation, as it is considered optional.
- Future enhancements could include symbolic link support or environment detection for smoother integration.
