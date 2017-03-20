overlay:
    kmod.present:
        - persist: True

docker-repo:
    pkgrepo.managed:
        - name: deb [arch=armhf] https://apt.dockerproject.org/repo raspbian-jessie testing
        - key_url: salt://docker.gpg

docker-engine:
    pkg.installed

docker:
    service.running:
        - enable: True
        - watch:
            - file: /etc/docker/daemon.json
        - require:
            - pkg: docker-engine

/etc/docker/daemon.json:
    file.managed:
        - source: salt://docker-daemon.json
