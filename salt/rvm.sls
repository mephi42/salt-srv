rvm:
    group.present: []
    user.present:
        - gid: rvm
        - home: /home/rvm
        - require:
            - group: rvm
