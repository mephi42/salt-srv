# Preparation

1. Add `dtoverlay=pi3-miniuart-bt` to `/boot/config.txt` (https://www.raspberrypi.org/forums/viewtopic.php?t=138223)
2. Boot RPi
3. `# echo "10.0.0.100 salt" >>/etc/hosts`
4. `# echo "rainbow" >/etc/hostname`
5. `# hostname $(cat /etc/hostname)`
6. `# mkdir -p /etc/salt && echo rainbow >/etc/salt/minion_id`
7. `# apt install salt-minion`
8. `# reboot`
