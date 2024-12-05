#!/bin/bash

cd /Metatrader
sudo git clone https://github.com/himalaya-quant/kasmvnc-mt5-controller.git
cd kasmvnc-mt5-controller
sudo npm i
sudo npm run build
sudo node dist/main.js mt5_server=${MT5_SERVER} kasmvnc_username=${CUSTOM_USER} kasmvnc_password=${PASSWORD}