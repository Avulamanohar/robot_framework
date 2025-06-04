#!/bin/bash
 
# Start Appium server
echo "🚀 Starting Appium server..."
appium -p 4723 > /home/appuser/appium_4723.log 2>&1 &
 
# Capture the UDID from the device list
echo "⚙️ Fetching connected device UDID..."
 
# Wait for ADB to initialize and list devices (increase time here if needed)
echo "⏳ Waiting for ADB to initialize..."
sleep 5
 
#!/bin/bash

while true; do
    # Extract the connected device list
    DEVICE_LIST=($(adb devices | grep -w "device" | awk '{print $1}'))
 
    # Debug: Show the connected devices
    echo "Connected devices: ${DEVICE_LIST[@]}"
 
    if [[ ${#DEVICE_LIST[@]} -ge 1 ]]; then
        echo "✅ Device connected successfully."
        break
    else
        echo "❌ No devices detected, retrying in 3 seconds..."
        sleep 3
    fi
done

 
# If no devices connected after retries, exit
if [[ ${#DEVICE_LIST[@]} -lt 1 ]]; then
    echo "❌ No devices connected. Exiting."
    exit 1
fi
 
# Assign the environment variable for the first device
DEVICE_ID=${DEVICE_LIST[0]}
 
# Export and persist the UDID
echo "✅ Assigning environment variables..."
{
    echo "export DEVICE_NAME='android'"
    echo "export UDID='$DEVICE_ID'"
} >> ~/.bashrc
 
# Optional: apply changes in the current shell
export DEVICE_NAME='android'
export UDID="$DEVICE_ID"
 
echo "📲 UDID: $UDID"
 
# Start the gotty terminal
echo "🚀 Starting gotty terminal..."
ttyd -W -p 8080 /bin/bash
 
# Keep the container running
tail -f /dev/null
 