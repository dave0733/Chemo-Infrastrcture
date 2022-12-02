#!/bin/sh


#echo ''
#echo ''
#echo '
#+-----------------------------------------------------+
#|                 DOWNLOADINING REDIS                 |
#+-----------------------------------------------------+
#'
#sudo wget http://download.redis.io/releases/redis-4.0.10.tar.gz;
#sudo tar -xvzf redis-4.0.10.tar.gz;

#wget http://download.redis.io/releases/redis-6.0.5.tar.gz;
#tar -xvzf redis-6.0.5.tar.gz;

echo ''
echo ''
echo '
+-----------------------------------------------------+
|                  INSTALLING REDIS                   |
+-----------------------------------------------------+
'
cd ./redis-4.0.10/deps;
sudo apt-get install build-essential
sudo make hiredis 
sudo make lua 
sudo make jemalloc 
sudo make linenoise

cd ..
sudo make; 
sudo make test; 
sudo make install;
sudo mkdir /etc/redis; 
sudo cp redis.conf /etc/redis; 
sudo adduser --system --group --no-create-home redis;
sudo mkdir /var/lib/redis;
sudo chown redis:redis /var/lib/redis/; sudo chmod 770 /var/lib/redis/;

echo ''
echo ''
echo '
+-----------------------------------------------------+
|               CONFIGURING REDIS FILE                |
+-----------------------------------------------------+
'
sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.backup
sudo sed -i '147s/supervised no/supervised systemd/' /etc/redis/redis.conf
sudo sed -i '69s/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
sudo sed -i '263s+./+/var/lib/redis+' /etc/redis/redis.conf
echo '
=============REDIS CONFIGURATION COMPLETE==============
'

echo ''
echo ''
echo '
+-----------------------------------------------------+
|            CREATING REDIS SERVICE FILE              |
+-----------------------------------------------------+
'

sudo touch /etc/systemd/system/redis.service
echo '[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/redis.service
echo '
==================CHECK HUGEPAGES=====================
'
sudo echo never > /sys/kernel/mm/transparent_hugepage/enabled
cat /sys/kernel/mm/transparent_hugepage/enabled
echo '
=============REDIS SERVICE FILE CREATED===============
'

echo ''
echo ''
echo '
+-----------------------------------------------------+
|             REDIS INSTALLATION COMPLETE             |
+-----------------------------------------------------+
'
sudo service redis restart;
sudo service redis status;

