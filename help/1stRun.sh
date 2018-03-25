#!/bin/bash
#
FILE=/1st_start.done

#test if already done
if [ ! -f $FILE ]; then
   echo "1st Run ---- Init"
   #
   # postgresql
   #
   echo "Init database"
   # modify ownership for mounted data area
   chown postgres:postgres /var/lib/pgsql/data
   postgresql-setup initdb
   echo "local   all             all             peer"             >  /var/lib/pgsql/data/pg_hba.conf
   echo "host    all             all             127.0.0.1/32 md5" >> /var/lib/pgsql/data/pg_hba.conf
   echo "host    all             all             ::1/128      md5" >> /var/lib/pgsql/data/pg_hba.conf
   systemctl enable postgresql
   systemctl restart postgresql
   #
   # rabbitmq
   #
   systemctl enable rabbitmq-server
   systemctl restart rabbitmq-server
   #
   # icecast
   #
   systemctl enable icecast
   #
   # php
   echo "update dateformat for php"
   echo "date.timezone = CET" > /etc/php.d/datetime.ini
   #
   # httpd
   #
   systemctl enable httpd
   systemctl restart httpd

   echo "install libretime please be patient ....."
   cd /libretime_src/libretime
   # patch for liquidsoap 1.3.x
   curl -L https://github.com/LibreTime/libretime/compare/master...radiorabe:feature/liquidsoap-1.3.0.patch 
   ./install -fiap
   touch $FILE
fi
