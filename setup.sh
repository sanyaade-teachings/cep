curl -sSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh 
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo touch /etc/docker/daemon.json
sudo bash -c 'echo "{\"experimental\": true}" > /etc/docker/daemon.json'
sudo mkdir ~/cait_workspace
sudo cp examples/cait/*.cait ~/cait_workspace
sudo systemctl restart docker
rm get-docker.sh
sudo touch /etc/cron.daily/docker-prune
sudo bash -c 'printf "#!/bin/bash\ndocker system prune -af  --filter \"until=$((30*24))h\"" > /etc/cron.daily/docker-prune'
sudo chmod +x /etc/cron.daily/docker-prune

sudo apt update
sudo sh -c "echo 'dtparam=spi=on' >> /boot/config.txt"
sudo apt-get install v4l-utils whois -y
sudo apt-get install portaudio19-dev mplayer graphviz libbluetooth-dev bluez-tools -y
sudo pip3 install docker-compose flask Flask-AutoIndex Flask-HTTPAuth flask-login flask_cors paho-mqtt gunicorn pyaudio lolviz cython pybluez
sudo pip3 install filelock wifi
sudo apt-get install -y libusb-1.0-0-dev libjpeg-dev libtiff5-dev libjasper-dev libpng-dev 
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev 
sudo apt-get install -y libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev 
sudo apt-get install -y libgtk2.0-dev libgtk-3-dev
sudo apt-get install -y libatlas-base-dev gfortran
sudo apt-get install -y libhdf5-dev libhdf5-serial-dev libhdf5-103
sudo apt-get install -y libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5
sudo apt-get install -y libilmbase-dev libopenexr-dev libgstreamer1.0-dev
sudo pip3 install opencv-contrib-python==4.5.2.52
sudo pip3 install -U numpy
sudo apt-get install npm nodejs -y
sudo touch /opt/accounts
sudo npm install -g configurable-http-proxy
sudo pip3 install notebook
sudo pip3 install jupyterhub
cp -R setup_scripts/homeassistant /home/pi
sudo cp setup_scripts/curt_containers.service /etc/systemd/system
sudo cp setup_scripts/cait_webapp.service /etc/systemd/system
sudo cp setup_scripts/start_curt_containers.sh /opt
sudo cp setup_scripts/start_cait.sh /opt
sudo systemctl daemon-reload
sudo systemctl enable curt_containers.service
sudo systemctl enable cait_webapp.service
sudo apt-get -y install raspberrypi-kernel-headers raspberrypi-kernel 

echo "export CURT_PATH=$PWD/src/curt/" >> ~/.bashrc 
echo "export CAIT_PATH=$PWD/src/cait/" >> ~/.bashrc 
echo "export CAIT_WEB_PATH=$PWD/src/cait/cortic_webapp/" >> ~/.bashrc 
echo "export PYTHONPATH=$PWD/src/curt/:$PWD/src/cait/:$PYTHONPATH" >> ~/.bashrc 

sudo sh -c 'echo "export CURT_PATH=$PWD/src/curt/" >> /root/.bashrc'
sudo sh -c 'echo "export CAIT_PATH=$PWD/src/cait/" >> /root/.bashrc'
sudo sh -c 'echo "export CAIT_WEB_PATH=$PWD/src/cait/cortic_webapp/" >> /root/.bashrc'
sudo sh -c 'echo "export PYTHONPATH=$PWD/src/curt/:$PWD/src/cait/:$PYTHONPATH" >> /root/.bashrc'

sudo docker pull homeassistant/home-assistant:stable
sudo docker pull cortictech/speech:0.52
sudo docker pull cortictech/nlp:0.52
sudo docker pull cortictech/vision:0.52
sudo docker pull cortictech/control:0.52
sudo docker pull cortictech/broker:0.51
sudo docker pull cortictech/smarthome:0.52

sudo reboot now
