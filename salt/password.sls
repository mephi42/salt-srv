pi:
    user.present:
        - password: {{ pillar['password'] }}
