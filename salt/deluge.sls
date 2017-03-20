deluged:
    pkg.installed

deluge-console:
    pkg.installed

/etc/default/deluged:
    file.replace:
        - pattern: ENABLE_DELUGED=0
        - repl: ENABLE_DELUGED=1

deluged-service:
    service.running:
        - name: deluged
        - enable: True
        - watch:
            - file: /etc/default/deluged
