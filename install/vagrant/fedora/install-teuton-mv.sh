#!/usr/bin/env bash

APP_NAME=teuton
VERSION=2.9.1
REPO_URL=https://github.com/teuton-software/teuton-tests
SAMPLES_FOLDER=teuton-tests
GEM_URL=https://rubygems.org/gems/teuton

dnf upgrade
dnf install -y vim tree nmap
dnf install -y neofetch

echo "[INFO] Install ruby and $APP_NAME"
dnf install -y ruby irb
gem install $APP_NAME

echo "[INFO] Download $SAMPLES_FOLDER"
dnf install -y git
git clone $REPO_URL
chown -R vagrant:vagrant $SAMPLES_FOLDER

echo "[INFO] Configure motd"
dnf install -y figlet
figlet $APP_NAME > /etc/motd
echo "" >> /etc/motd
echo "$APP_NAME ($VERSION)" >> /etc/motd
echo "$GEM_URL" >> /etc/motd

echo "[INFO] Configure aliases"
echo "# Adding more alias" >> /home/vagrant/.bashrc
echo "alias c='clear'" >> /home/vagrant/.bashrc
echo "alias v='vdir'" >> /home/vagrant/.bashrc

lsb_release -d
