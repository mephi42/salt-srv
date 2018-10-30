local:
    timezone.system:
        - name: {{ pillar['timezone'] }}

rsyslog:
    service.running:
        - watch:
            - timezone: local
