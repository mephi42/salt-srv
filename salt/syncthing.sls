include:
    - nginx

syncthing-repo:
    pkgrepo.managed:
        - name: deb http://apt.syncthing.net/ syncthing stable
        - key_url: salt://syncthing.gpg

syncthing:
    pkg.installed: []
    group.present: []
    user.present:
        - gid: syncthing
        - home: /home/syncthing
        - groups:
            - debian-deluged
        - require:
            - group: syncthing

syncthing@syncthing:
    service.running:
       - enable: True

{% for dir in ['/var/lib/deluged/Downloads',
               '/opt/redmine/backups',
               '/opt/tt-rss/backups'] %}
{{ dir }}/.stfolder:
    file.directory:
       - user: syncthing
       - group: syncthing
       - force: True

{{ dir }}/.stignore:
    file.managed:
       - user: syncthing
       - group: syncthing
{% endfor %}

/etc/nginx/sites-available/syncthing:
    file.managed:
        - source: salt://syncthing-nginx

/etc/nginx/sites-enabled/syncthing:
    file.symlink:
        - target: ../sites-available/syncthing
