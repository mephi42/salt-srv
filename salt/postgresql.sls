postgresql:
    pkg.installed

www-data:
    postgres_user.present
