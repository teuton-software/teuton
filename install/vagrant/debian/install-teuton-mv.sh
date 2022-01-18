#!/usr/bin/env bash

APP_NAME=teuton
VERSION=2.1.11
REPO_URL=https://github.com/teuton-software/teuton-tests
SAMPLES_FOLDER=teuton-tests
GEM_URL=https://rubygems.org/gems/teuton

apt update
apt install -y vim tree nmap
apt install -y neofetch

echo "[INFO] Install ruby and $APP_NAME"
apt install -y ruby irb
gem install $APP_NAME

echo "[INFO] Download $SAMPLES_FOLDER"
apt install -y git
git clone $REPO_URL
chown -R vagrant:vagrant $SAMPLES_FOLDER

echo "[INFO] Configure motd"
apt install -y figlet
figlet $APP_NAME > /etc/motd
echo "" >> /etc/motd
echo "$APP_NAME ($VERSION)" >> /etc/motd
echo "$GEM_URL" >> /etc/motd

echo "[INFO] Configure aliases"
echo "# Adding more alias" >> /home/vagrant/.bashrc
echo "alias c='clear'" >> /home/vagrant/.bashrc
echo "alias v='vdir'" >> /home/vagrant/.bashrc

lsb_release -d
