# Preparation

1. `pc# dd if=~/Downloads/2017-03-02-raspbian-jessie-lite.img of=/dev/sde bs=4M status=progress`
2. `pc# echo "dtoverlay=pi3-miniuart-bt" >>/media/$USER/boot/config.txt`
3. Boot RPi
4. `rpi# echo "10.0.0.100 salt" >>/etc/hosts`
5. `rpi# echo "rainbow" >/etc/hostname`
6. `rpi# hostname $(cat /etc/hostname)`
7. `rpi# mkdir -p /etc/salt && echo rainbow >/etc/salt/minion_id`
8. `rpi# apt install -y salt-minion`
