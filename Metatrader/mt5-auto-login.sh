#!/bin/bash

echo "###################################################"
echo "#                     WHOAMI                      #"
echo "###################################################"
whoami
echo "###################################################"
echo "#                   WHOAMI-END                    #"
echo "###################################################"

cd /Metatrader
sudo git clone https://github.com/himalaya-quant/kasmvnc-mt5-controller.git
cd kasmvnc-mt5-controller
sudo npm i
sudo npm start