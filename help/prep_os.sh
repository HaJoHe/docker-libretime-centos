#!/bin/bash
#

#
# Install all OS related stuff
#
yum -y install epel-release

#
# radiorabe stuff (liquidsoap)
#
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
curl -o /etc/yum.repos.d/liquidsoap.repo http://download.opensuse.org/repositories/home:/radiorabe:/liquidsoap/CentOS_7/home:radiorabe:liquidsoap.repo

yum -y install git wget postgresql-server postgresql-contrib \
 php php-amqplib php-pgsql httpd python-pip icecast iproute liquidsoap 


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
# Clean up packagemanager
#  
yum clean all
rm -rf /var/cache/yum
rm -rf rabbitmq-server-3.6.10-1.el7.noarch.rpm


# define postgres password file
echo "localhost:5432:airtime:airtime:airtime" > /root/.pgpass
chmod 600 /root/.pgpass 

# activate services
systemctl enable rabbitmq-server
systemctl enable postgresql
systemctl enable httpd
systemctl enable icecast
#
