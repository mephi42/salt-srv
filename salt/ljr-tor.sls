include:
    - nginx
    - tor

/etc/nginx/sites-available/ljr-tor:
    file.managed:
        - source: salt://ljr-tor-nginx

/etc/nginx/sites-enabled/ljr-tor:
    file.symlink:
        - target: ../sites-available/ljr-tor

lj.rossia.org:
    host.present:
        - ip: 127.0.0.1
