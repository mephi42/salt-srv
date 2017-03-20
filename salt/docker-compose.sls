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
