# How I Create BigBlueButton 2.0 beta's container with docker-compose.

<pre>
chmod 700 setup.sh config.sh
</pre>

## Please using domain name instead of ip address.
<pre>
./config.sh &lt;Your domain&gt;
</pre>
## Update the domain certificate files:

Put your domain certificate certifcate:

<pre>
fullchain.pem
privkey.pem
</pre>

or create a softlink something like below:

<pre>
ln -vsf /etc/ssl/your-domain/fullchain.pem fullchain.pem
</pre>

## Create your bigbluebutton container.

<pre>
docker-compose up -d
</pre>

## Wait for startup or issue the following command to check out
the bbb is container's service name.
<pre>
docker-compose exec bbb netstat -ntlp
</pre>

## Enter the container:
<pre>
docker-compose exec bbb bash
</pre>
