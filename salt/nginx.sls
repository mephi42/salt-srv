nginx:
    pkg.installed: []
    service.running:
        - enable: True
        - watch:
            - file: /etc/nginx/*
