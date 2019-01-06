rvm:
    group.present: []
    user.present:
        - gid: rvm
        - home: /home/rvm
        - require:
            - group: rvm

gnupg2:
    pkg.installed

gpg2 --batch --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3:
    cmd.run:
        - runas: rvm
        - unless: gpg2 --list-keys 409B6B1796C275462A1703113804BB82D39DC0E3

gpg2 --batch --recv-keys 7D2BAF1CF37B13E2069D6956105BD0E739499BDB:
    cmd.run:
        - runas: rvm
        - unless: gpg2 --list-keys 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
