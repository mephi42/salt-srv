syncthing-repo:
    pkgrepo.managed:
        - name: deb http://apt.syncthing.net/ syncthing release
        - key_url: salt://syncthing.gpg

syncthing:
    pkg.installed
