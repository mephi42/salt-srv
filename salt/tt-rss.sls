include:
    - git

php5-cli:
    pkg.installed

php5-fpm:
    pkg.installed

php5-pgsql:
    pkg.installed

nginx:
    pkg.installed

/etc/nginx/sites-available/tt-rss:
    file.managed:
        - source: salt://tt-rss-nginx

/etc/nginx/sites-enabled/tt-rss:
    file.symlink:
        - target: ../sites-available/tt-rss

nginx-service:
    service.running:
        - name: nginx
        - watch:
            - file: /etc/nginx/*

https://tt-rss.org/gitlab/fox/tt-rss.git:
    git.latest:
        - target: /opt/tt-rss

/opt/tt-rss/config.php:
    file.managed:
        - source: salt://tt-rss-config.php

/opt/tt-rss/cache:
    file.directory:
        - user: www-data
        - group: www-data
        - recurse:
            - user
            - group

/opt/tt-rss/feed-icons:
    file.directory:
        - user: www-data
        - group: www-data
        - recurse:
            - user
            - group

/opt/tt-rss/lock:
    file.directory:
        - user: www-data
        - group: www-data
        - recurse:
            - user
            - group

/etc/systemd/system/tt-rss-updater.service:
    file.managed:
        - source: salt://tt-rss-updater.service

tt-rss-updater:
    service.running:
       - enable: True
