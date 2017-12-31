# How I Create BigBlueButton 2.0 beta's container with docker-compose.

## Update the domain certificate files:
Overwrite domain's certifcate files in this working directory:

<pre>
fullchain.pem
privkey.pem
</pre>

or create a softlink something like below:

<pre>
ln -vsf /etc/ssl/your-domain/fullchain.pem fullchain.pem
</pre>

## make sure two file are executable.
<pre>
chmod 700 setup.sh config.sh
</pre>

## Please using domain name instead of ip address.
<pre>
./config.sh &lt;Your domain&gt;
</pre>

Check the result by
<pre>
git diff
</pre>

Rollback changs to last commit:(or rollback, if something wrong happens)
<pre>
git checkout -- .
</pre>


## Create your bigbluebutton container.
<pre>
docker-compose up -d
</pre>

## Wait for startup or issue the following command to check out
the bbb is container's service name.
<pre>
docker-compose logs -f
</pre>

<pre>
docker-compose exec bbb netstat -ntlp
</pre>

## Add a nginx proxy on your host
<pre>
 server {
      listen 443 ssl http2;
      listen [::]:443 ssl http2;

      resolver 168.95.192.1 192.168.1.1;
      set $backend "https://&lt;your-domain&gt;:10443";

      server_name &lt;your-domain&gt;;

      ssl_certificate /etc/nginx/ssl/fullchain.pem;

      ssl_certificate_key /etc/nginx/ssl/privkey.pem;

      add_header Strict-Transport-Security "max-age=15768000; includeSubdomains; preload" always;

  location /ws {
          proxy_pass https://&lt;your-domain&gt;:7443;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "Upgrade";
          proxy_read_timeout 6h;
          proxy_send_timeout 6h;
          client_body_timeout 6h;
          send_timeout 6h;
  }

      location / {
          proxy_set_header        Host                $http_host;
          proxy_set_header        X-Real-IP           $remote_addr;
          proxy_set_header        X-Forwarded-For     $proxy_add_x_forwarded_for;
          proxy_set_header        X-Forwarded-Proto   $scheme;
          proxy_intercept_errors  on;
          proxy_http_version      1.1;

          proxy_pass $backend;

      }

  }
</pre>

# Others

## You can see the secret
<pre>
docker-compose exec bbb bbb-conf --secret
</pre>

## Enter the container:
<pre>
docker-compose exec bbb bash
</pre>

## You have to startup nginx manually if your centificate's key have password protected
<pre>
docker-compose exec bbb nginx
Enter PEM pass phrase:
root@bbb:~/bbb#
</pre>

## Change the shared secret

# Salt which is used by 3rd-party apps to authenticate api calls
securitySalt=a6fe48d5f7eda7a344181719a8c75da8
<pre>
bigbluebutton.properties
</pre>

# This is the security salt that must match the value set in the BigBlueButton server
String salt = "a6fe48d5f7eda7a344181719a8c75da8";
<pre>
bbb_api_conf.jsp
</pre>
