include:
    - git
    - nginx

php7.0-cli:
    pkg.installed

php7.0-fpm:
    pkg.installed

php7.0-pgsql:
    pkg.installed

/etc/nginx/sites-available/tt-rss:
    file.managed:
        - source: salt://tt-rss-nginx

/etc/nginx/sites-enabled/tt-rss:
    file.symlink:
        - target: ../sites-available/tt-rss

https://tt-rss.org/fox/tt-rss.git:
    git.latest:
        - target: /opt/tt-rss
        - branch: master

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

/opt/tt-rss/backups:
    file.directory:
        - user: www-data
        - group: www-data

/opt/tt-rss/backup:
    file.managed:
        - source: salt://tt-rss-backup
        - user: www-data
        - group: www-data
        - mode: 0755

/etc/systemd/system/tt-rss-backup.service:
    file.managed:
        - source: salt://tt-rss-backup.service

/etc/systemd/system/tt-rss-backup.timer:
    file.managed:
        - source: salt://tt-rss-backup.timer

tt-rss-backup.timer:
    service.running:
       - enable: True
