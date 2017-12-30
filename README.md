# bbb
<pre>
chmod 700 setup.sh config.sh
</pre>

##Please using domain name instead of ipaddress.
<pre>
./config.sh <Your domain>
</pre>
##Update the domain certificate files:
Put your domain certificate certifcate:
fullchain.pem
privkey.pem

or create softlink something like below:
ln -vsf /etc/ssl/your-domain/fullchain.pem fullchain.pem

##Create your bigbluebutton container.
docker-compose up -d
