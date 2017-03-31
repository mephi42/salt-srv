include:
    - nginx
    - rvm

ruby-2.3.3-deps:
    pkg.installed:
        - pkgs:
            - libssl-dev

ruby-2.3.3:
    rvm.installed:
        - user: rvm
        - require:
            - pkg: ruby-2.3.3-deps

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
        - ruby: ruby-2.3.3
        - user: rvm
        - require:
            - pkg: redmine-deps

bundler:
    gem.installed:
        - user: rvm
        - ruby: ruby-2.3.3@redmine-gems

/opt:
    archive.extracted:
        - source: http://www.redmine.org/releases/redmine-3.3.2.tar.gz
        - source_hash: md5=8e403981dc3a19a42ee978f055be62ca
        - user: www-data
        - group: www-data

/opt/redmine-3.3.2/config/database.yml:
    file.managed:
        - source: salt://redmine-database.yml

/opt/redmine-3.3.2/.bundle:
    file.directory:
        - user: rvm
        - group: rvm

/opt/redmine-3.3.2/Gemfile.lock:
    file.managed:
        - user: rvm
        - group: rvm

/opt/redmine-3.3.2/Gemfile.local:
    file.managed:
        - source: salt://redmine-Gemfile.local
        - user: www-data
        - group: www-data

/opt/redmine-3.3.2/bundle:
    file.managed:
        - source: salt://redmine-bundle
        - user: www-data
        - group: www-data
        - mode: 0755

/opt/redmine-3.3.2/bundle install --without development test:
    cmd.run:
        - runas: rvm

/opt/redmine-3.3.2/locations.ini:
    file.managed:
        - user: rvm
        - group: rvm

/opt/redmine-3.3.2/bundle exec env --unset=PASSENGER_LOCATION_CONFIGURATION_FILE passenger-config about --make-locations-ini >/opt/redmine-3.3.2/locations.ini:
    cmd.run:
        - runas: rvm

mkdir -p $(/opt/redmine-3.3.2/bundle exec passenger-config about support-binaries-dir):
    cmd.run:
        - runas: rvm

/opt/redmine-3.3.2/bundle exec passenger-config build-native-support:
    cmd.run:
        - runas: rvm

/opt/redmine-3.3.2/bundle exec passenger-config install-agent:
    cmd.run:
        - runas: rvm

/opt/redmine-3.3.2/bundle exec passenger-config install-standalone-runtime --engine nginx:
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
