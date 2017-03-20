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
        - watch:
            - file: /etc/default/deluged

pi-is-in-debian-deluged:
    user.present:
        - name: pi
        - groups:
            - debian-deluged

/var/lib/deluged/config/auth:
    file.managed:
        - mode: 660
