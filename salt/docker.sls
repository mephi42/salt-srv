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

python-pip:
    cmd.run:
        - name: easy_install pip==8.0.3
        - unless: which pip
        - reload_modules: True

six:
    pip.installed:
        - name: six
        - require:
            - cmd: python-pip

docker-compose:
    pip.installed:
        - name: docker-compose
        - require:
            - cmd: python-pip
            - pip: six
