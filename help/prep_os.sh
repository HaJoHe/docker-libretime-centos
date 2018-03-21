#!/bin/bash
#

#
# Install all OS related stuff
#
yum -y install epel-release

yum -y install git wget postgresql-server postgresql-contrib \
 php php-amqplib httpd python-pip icecast 
#ln -fs /usr/bin/python3 /usr/bin/python

#postgresql
echo "Init database"
postgresql-setup initdb
echo "host    all             all             0.0.0.0/0 trust" >> /var/lib/pgsql/data/pg_hba.conf
#echo "listen_addresses='*'" >> /var/lib/pgsql/data/pg_hba.conf
systemctl restart postgresql

#
#  Erlang for RabbitMQ
#
cat <<EOF > /etc/yum.repos.d/rabbitmq-erlang.repo 
[rabbitmq-erlang]
name=rabbitmq-erlang
baseurl=https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
gpgcheck=1
gpgkey=https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc
repo_gpgcheck=0
enabled=1
EOF

# Install rabbitmq
wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.10/rabbitmq-server-3.6.10-1.el7.noarch.rpm
rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
yum install -y rabbitmq-server-3.6.10-1.el7.noarch.rpm

# update python environment
echo "update pip"
pip install --upgrade pip

#
# get latest Libretime
#
echo "Clone libretime"
mkdir /libretime_src
cd /libretime_src
git clone https://github.com/LibreTime/libretime.git

#
# activate RabbitMQ management
#
echo "NODENAME=rabbitmq@localhost" > /etc/rabbitmq/rabbitmq-env.conf
rabbitmq-plugins enable rabbitmq_management
#

#
# install lastest libretime
#
echo "Install libretime"
cp /install /libretime_src/libretime/install
cd /libretime_src/libretime
./install -fiap --distribution=centos --release=7
cd /
#

#
# Clean up packagemanager
#  
yum clean all
rm -rf /var/cache/yum
rm -rf rabbitmq-server-3.6.10-1.el7.noarch.rpm
