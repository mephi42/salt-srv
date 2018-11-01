samba:
  pkg.installed

smbd:
    service.running:
        - enable: True
        - require:
            - pkg: samba
