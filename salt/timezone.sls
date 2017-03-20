local:
    timezone.system:
        - name: Europe/Moscow

rsyslog:
    service.running:
        - watch:
            - timezone: local
