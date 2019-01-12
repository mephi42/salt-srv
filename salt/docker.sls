overlay:
    kmod.present:
        - persist: True

docker-repo:
    pkgrepo.managed:
        - name: deb [arch=armhf] https://download.docker.com/linux/debian stretch stable
        - key_url: salt://docker.gpg

docker-ce:
    pkg.installed

docker:
    service.running:
        - enable: True
        - watch:
            - file: /etc/docker/daemon.json
        - require:
            - pkg: docker-ce

/etc/docker/daemon.json:
    file.managed:
        - source: salt://docker-daemon.json

docker-group:
  group.present:
    - name: docker
    - system: True
    - addusers:
      - pi
