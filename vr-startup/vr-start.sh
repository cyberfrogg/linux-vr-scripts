#! /bin/bash

# Edit path here
ALVR_PATH="$HOME/.apps/ALVR-v20.7.1/alvr_streamer_linux/bin/alvr_dashboard"
WLX_OVERLAY_PATH="$HOME/.apps/WlxOverlay/WlxOverlay-S-v0.3.2-x86_64.AppImage"
OSCAVMGR_PATH="$HOME/.apps/oscavmgr-alvr/oscavmgr-alvr"
VRCADVERT_PATH="$HOME/.apps/vrc-advert/VrcAdvert"

# Const
VRSTARTUP_LOGS_PREFIX="\e[1;36mvrstartup:\e[0m"

# Cleanup
cleanup() {
    echo -e "$VRSTARTUP_LOGS_PREFIX << Clean Up >>"
    
    # Kill vrmonitor process if running
    echo -e "$VRSTARTUP_LOGS_PREFIX Killing vrmonitor (steamvr)..."
    if pgrep -x "vrmonitor" > /dev/null; then
        pkill -x "vrmonitor"
    fi
    
    # Kill ALVR dashboard process if running
    echo -e "$VRSTARTUP_LOGS_PREFIX Killing vrmonitor ALVR Dashboard..."
    if [ -n "$ALVR_PID" ]; then
        kill "$ALVR_PID" >/dev/null 2>&1
    fi
    
    # Kill WlxOverlay app process if running
    echo -e "$VRSTARTUP_LOGS_PREFIX Killing WlxOverlay..."
    if [ -n "$WLX_OVERLAY_PID" ]; then
        kill "$WLX_OVERLAY_PID" >/dev/null 2>&1
    fi
    
    # Kill OSCAVMGR app process if running
    echo -e "$VRSTARTUP_LOGS_PREFIX Killing OSCAVMGR..."
    if [ -n "$OSCAVMGR_PID" ]; then
        kill "$OSCAVMGR_PID" >/dev/null 2>&1
    fi
    
    # Kill VrcAdvert app process if running
    echo -e "$VRSTARTUP_LOGS_PREFIX Killing VrcAdvert..."
    if [ -n "$VRCADVERT_PID" ]; then
        kill "$VRCADVERT_PID" >/dev/null 2>&1
    fi
    
    echo -e "$VRSTARTUP_LOGS_PREFIX << Exit >>"
    exit 1
}

trap cleanup SIGINT

# Initialize
clear
echo -e "$VRSTARTUP_LOGS_PREFIX << VR START >>"
sleep 1
echo -e "$VRSTARTUP_LOGS_PREFIX 1 second passed"

if ! pgrep -x "steam" > /dev/null; then
    echo -e "$VRSTARTUP_LOGS_PREFIX Steam is not running. Launch it first!"
    exit 1
fi

# Initialize remove logs to not to make it grow a lot
rm alvr_output.log

# Start ALVR
echo -e "$VRSTARTUP_LOGS_PREFIX Starting up ALVR...."
"$ALVR_PATH" > alvr_output.log &
ALVR_PID=$!

while ! pgrep -x "vrmonitor" > /dev/null; do
    sleep 1
done

echo -e "$VRSTARTUP_LOGS_PREFIX SteamVR detected!"
sleep 1

# Start WlxOverlay
echo -e "$VRSTARTUP_LOGS_PREFIX Starting up WlxOverlay..."
"$WLX_OVERLAY_PATH" &
WLX_OVERLAY_APP_PID=$!
sleep 1

# Start VrcAdvert
echo -e "$VRSTARTUP_LOGS_PREFIX Starting up VRCADVERT..."
"$VRCADVERT_PATH" oscavmgr 9402 9002 &
VRCADVERT_PID=$!
sleep 2

# Start OSCAVMGR
echo -e "$VRSTARTUP_LOGS_PREFIX Starting up OSCAVMGR..."
"$OSCAVMGR_PATH" &
OSCAVMGR_PID=$!
sleep 2


echo -e "$VRSTARTUP_LOGS_PREFIX Everything is started! Good Luck in VR!"

# wait
wait $ALVR_PID
wait $WLX_OVERLAY_PID
wait $VRCADVERT_PID
wait $OSCAVMGR_PID