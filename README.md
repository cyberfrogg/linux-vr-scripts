# linux-vr-scripts

This will be a collection of simple scripts for better VR experience on Linux.

## vr-startup
This is a script, that automaticly starts [ALVR](https://github.com/alvr-org/ALVR), [WlxOverlay](https://github.com/galister/wlx-overlay-s), [OSCVMGR](https://github.com/galister/oscavmgr) and [VrcAdvert](https://github.com/galister/VrcAdvert). Also it shut downs everything on script exit *(CTRL + C)*

### How to use vr-startup
1. First, edit these file paths:
- ALVR_PATH="YOUR_FILE_PATH"
- WLX_OVERLAY_PATH="YOUR_FILE_PATH"
- OSCAVMGR_PATH="YOUR_FILE_PATH"
- VRCADVERT_PATH="YOUR_FILE_PATH"

2. Open ALVR Dashboard manually and set `Settings > SteamVR Launcher > Open and close SteamVR with dashboard` to `true` to make SteamVR start automaticly. Its necessary. Close ALVR Dashboard
3. Just start the script
4. CTRL+C to exit
