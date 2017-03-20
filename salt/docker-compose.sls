python-virtualenv:
    pkg.installed

/opt/docker-compose:
    virtualenv.managed:
        - requirements: salt://docker-compose-requirements.txt

/usr/bin/docker-compose:
    file.managed:
        - source: salt://docker-compose
        - mode: 0755
