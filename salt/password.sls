# openssl passwd -6

pi-password:
    user.present:
        - name: pi
        - password: {{ pillar['password'] }}
