#!bin/bash

sudo apt -y update
sudo apt install docker.io -y
sudo systemctl start docker
sudo docker build -t app-runner:1.0 .
sudo docker run -d -p 80:5000
