tor:
    pkg.installed: []
    service.running:
        - enable: True

privoxy:
    pkg.installed

/etc/privoxy/config:
    file.append:
        - text:
            - "forward-socks5 / 127.0.0.1:9050 ."
            - "accept-intercepted-requests 1"

privoxy-service:
    service.running:
        - name: privoxy
        - enable: True
        - watch:
            - file: /etc/privoxy/*
