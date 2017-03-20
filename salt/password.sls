pi-password:
    user.present:
        - name: pi
        - password: {{ pillar['password'] }}
