# Preparation

* `pc# dd if=~/Downloads/2018-10-09-raspbian-stretch-lite.img of=/dev/sde bs=4M status=progress`
* `pc# echo "dtoverlay=pi3-miniuart-bt" >>/media/$USER/boot/config.txt`
* Boot RPi
* `rpi# echo "10.0.0.100 salt" >>/etc/hosts`
* `rpi# echo "rainbow" >/etc/hostname`
* `rpi# hostname $(cat /etc/hostname)`
* `rpi# mkdir -p /etc/salt && echo $(cat /etc/hostname) >/etc/salt/minion_id`
* `rpi# wget -O - https://repo.saltstack.com/apt/debian/9/armhf/latest/SALTSTACK-GPG-KEY.pub | apt-key add -`
* `rpi# echo "deb http://repo.saltstack.com/apt/debian/9/armhf/latest stretch main" >/etc/apt/sources.list.d/saltstack.list`
* `rpi# apt install -y salt-minion`
* `pc# salt-key -a rainbow`
