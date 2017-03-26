syncthing-repo:
    pkgrepo.managed:
        - name: deb http://apt.syncthing.net/ syncthing release
        - key_url: salt://syncthing.gpg

/etc/systemd/system/syncthing.service:
    file.managed:
        - source: salt://syncthing.service

syncthing:
    pkg.installed: []
    group.present: []
    user.present:
        - gid: syncthing
        - home: /home/syncthing
        - require:
            - group: syncthing
    service.running:
       - enable: True
