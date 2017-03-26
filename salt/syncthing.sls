syncthing-repo:
    pkgrepo.managed:
        - name: deb http://apt.syncthing.net/ syncthing release
        - key_url: salt://syncthing.gpg

syncthing:
    pkg.installed: []
    group.present: []
    user.present:
        - gid: syncthing
        - home: /home/syncthing
        - require:
            - group: syncthing

syncthing@syncthing:
    service.running:
       - enable: True
