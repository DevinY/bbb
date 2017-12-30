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
docker-compose exec bbb netstat -ntlp
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

