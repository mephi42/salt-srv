fail2ban:
    pkg.installed

sendmail:
    pkg.installed

/etc/fail2ban/jail.d/recidive.conf:
    file.managed:
        - source: salt://jail-recidive.conf

fail2ban-service:
    service.running:
        - name: fail2ban
        - enable: True
        - watch:
            - file: /etc/fail2ban/jail.d/*
