#!/bin/bash

echo "##########################################"
echo "# MT5 PWD                                #"
echo "##########################################"
echo $MT5_PASSWORD
echo "##########################################"

# Create the initial configuration files
cp /Metatrader/mt5_initial_config.ini /config/.wine/drive_c/
echo "[Common]" >> /config/.wine/drive_c/mt5_initial_config.ini
echo "Login=${MT5_LOGIN}" >> /config/.wine/drive_c/mt5_initial_config.ini
echo "Password=${MT5_PASSWORD}" >> /config/.wine/drive_c/mt5_initial_config.ini
echo "Server=${MT5_SERVER}" >> /config/.wine/drive_c/mt5_initial_config.ini