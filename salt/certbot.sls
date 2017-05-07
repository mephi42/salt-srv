jessie-backports-repo:
    pkgrepo.managed:
        - name: deb http://httpredir.debian.org/debian jessie-backports main
        - key_url: salt://jessie.gpg

certbot:
    pkg.installed:
        - fromrepo: jessie-backports
