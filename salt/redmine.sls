{% set ruby_version = '2.4.5' %}
{% set redmine_version = '3.3.9' %}
{% set redmine_md5 = 'eeb4e92681987fe1726cb962803d5cf1' %}

include:
    - nginx
    - rvm

ruby-{{ ruby_version }}-deps:
    pkg.installed:
        - pkgs:
            - libssl-dev

ruby-{{ ruby_version }}:
    rvm.installed:
        - user: rvm
        - opts:
            - -j
            - {{ grains['num_cpus'] }}
        - require:
            - pkg: ruby-{{ ruby_version }}-deps

redmine-deps:
    pkg.installed:
        - pkgs:
            - ccache
            - clang
            - libcurl4-openssl-dev
            - libmagickcore-dev
            - libmagickwand-dev
            - libpq-dev

redmine-gems:
    rvm.gemset_present:
        - ruby: ruby-{{ ruby_version }}
        - user: rvm
        - require:
            - pkg: redmine-deps

bundler:
    gem.installed:
        - user: rvm
        - ruby: ruby-{{ ruby_version }}@redmine-gems

/opt:
    archive.extracted:
        - source: http://www.redmine.org/releases/redmine-{{ redmine_version }}.tar.gz
        - source_hash: md5={{ redmine_md5 }}
        - user: www-data
        - group: www-data

/opt/redmine:
    file.symlink:
        - target: redmine-{{ redmine_version }}

/opt/redmine/config/database.yml:
    file.managed:
        - source: salt://redmine-database.yml

/opt/redmine/.bundle:
    file.directory:
        - user: rvm
        - group: rvm

/opt/redmine/.bundle/config:
    file.managed:
        - user: rvm
        - group: rvm

/opt/redmine/Gemfile.lock:
    file.managed:
        - user: rvm
        - group: rvm

/opt/redmine/Gemfile.local:
    file.managed:
        - source: salt://redmine-Gemfile.local
        - user: www-data
        - group: www-data

/opt/redmine/bundle:
    file.managed:
        - source: salt://redmine-bundle
        - user: www-data
        - group: www-data
        - mode: 0755

/opt/redmine/bundle install --without development test:
    cmd.run:
        - runas: rvm

/opt/redmine/locations.ini:
    file.managed:
        - user: rvm
        - group: rvm

/opt/redmine/bundle exec env --unset=PASSENGER_LOCATION_CONFIGURATION_FILE bash -c 'passenger-config about --make-locations-ini >/opt/redmine/locations.ini':
    cmd.run:
        - runas: rvm

mkdir -p $(/opt/redmine/bundle exec passenger-config about support-binaries-dir):
    cmd.run:
        - runas: rvm

/opt/redmine/bundle exec passenger-config build-native-support:
    cmd.run:
        - runas: rvm

/opt/redmine/bundle exec passenger-config install-agent:
    cmd.run:
        - runas: rvm

/opt/redmine/bundle exec passenger-config install-standalone-runtime --engine nginx:
    cmd.run:
        - runas: rvm

/etc/systemd/system/redmine.service:
    file.managed:
        - source: salt://redmine.service

redmine:
    service.running:
       - enable: True

/etc/nginx/sites-available/redmine:
    file.managed:
        - source: salt://redmine-nginx

/etc/nginx/sites-enabled/redmine:
    file.symlink:
        - target: ../sites-available/redmine

/opt/redmine/backup:
    file.managed:
        - source: salt://redmine-backup
        - user: www-data
        - group: www-data
        - mode: 0755

/etc/systemd/system/redmine-backup.service:
    file.managed:
        - source: salt://redmine-backup.service

/etc/systemd/system/redmine-backup.timer:
    file.managed:
        - source: salt://redmine-backup.timer

redmine-backup.timer:
    service.running:
       - enable: True
