Staging
=======

Steps taken:

- added `bruno`, `murtaza` and `deploy` users
- added `bruno` and `murtaza` to `admin` and `sudo` groups
- disabled SSH password logins (only keys)
- added Bruno and Murtaza's keys to `root` user for login
- installed RVM (multi-user mode)
- installed Ruby 2.3.1
- added Postgresql.org APT source
- installed PG 9.4.7
- added nginx.org APT source
- installed nginx 1.9.15
- installed libpq-dev
- added APT source for node (https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions)
- installed node 4.x LTS

added upstart job:

<pre>
description "boatbook"

start on runlevel [2]
stop on runlevel [016]

setuid deploy
setgid deploy

respawn

env RAILS_ENV=staging

chdir /home/deploy/apps/boatbook

exec bash -c "source /usr/local/rvm/scripts/rvm && rvm use 2.3.1 && bundle exec puma >> /home/deploy/apps/boatbook/log/upstart.log 2>&1"
</pre>

added nginx config:
<pre>
upstream foo {
        server unix:///home/deploy/apps/boatbook/tmp/sockets/puma.sock fail_timeout=0;
}

server {
        listen 443;
        server_name staging.vrsapp.uk;

        ssl on;
        ssl_certificate /etc/nginx/ssl/chained.pem;
        ssl_certificate_key /etc/nginx/ssl/domain.key;
        ssl_session_timeout 5m;
        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA;
        ssl_session_cache shared:SSL:50m;
        #ssl_dhparam /etc/ssl/certs/dhparam.pem;
        ssl_prefer_server_ciphers on;

        root /home/deploy/apps/boatbook/public;

        gzip on;

        location ^~ /assets/ {
                gzip_static on;
                expires max;
                add_header Cache-Control public;
        }

        try_files $uri/index.html $uri @foo;
        location @foo {
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $host;
                proxy_set_header Strict-Transport-Security "max-age=31536000; includeSubDomains";
                proxy_set_header X-NginX-Proxy true;

                proxy_redirect off;
                proxy_pass http://foo;
        }

        error_page 500 502 503 504 /500.html;
        client_max_body_size 100M;
        keepalive_timeout 10;
}
</pre>
