openssh-server:
    pkg.installed

ssh:
    service.running:
        - enable: True

beep:
    ssh_auth.present:
        - user: pi
        - source: salt://beep.id_ecdsa.pub
