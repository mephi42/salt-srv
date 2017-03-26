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
        - groups:
            - debian-deluged
        - require:
            - group: syncthing

syncthing@syncthing:
    service.running:
       - enable: True

/var/lib/deluged/Downloads/.stfolder:
    file.managed:
       - user: syncthing
       - group: syncthing

/var/lib/deluged/Downloads/.stignore:
    file.managed:
       - user: syncthing
       - group: syncthing
