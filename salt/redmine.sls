include:
    - rvm

ruby-2.4.0-deps:
    pkg.installed:
        - pkgs:
            - libssl-dev

ruby-2.4.0:
    rvm.installed:
        - user: rvm
        - require:
            - pkg: ruby-2.4.0-deps

redmine-deps:
    pkg.installed:
        - pkgs:
            - libpq-dev

redmine-gems:
    rvm.gemset_present:
        - ruby: ruby-2.4.0
        - user: rvm
        - require:
            - pkg: redmine-deps

bundler:
    gem.installed:
        - user: rvm
        - ruby: ruby-2.4.0@redmine-gems

/opt:
    archive.extracted:
        - source: http://www.redmine.org/releases/redmine-3.3.2.tar.gz
        - source_hash: md5=8e403981dc3a19a42ee978f055be62ca

/opt/redmine-3.3.2/config/database.yml:
    file.managed:
        - source: salt://redmine-database.yml

/opt/redmine-3.3.2/.bundle:
    file.directory:
        - user: www-data
        - group: www-data

. /home/rvm/.rvm/scripts/rvm && rvm 2.4.0 && rvm gemset use redmine-gems && bundle install --without development test:
    cmd.run:
        - cwd: /opt/redmine-3.3.2
        - runas: rvm
        - shell: /bin/bash
