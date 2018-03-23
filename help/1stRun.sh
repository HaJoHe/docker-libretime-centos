#!/bin/bash
#
FILE=/1st_start.done

#test if already done
if [ ! -f $FILE ]; then
   echo "1st Run ---- Init"
   echo "Init database"
   postgresql-setup initdb
   echo "host    all             all             0.0.0.0/0 trust" >>  /var/lib/pgsql/data/pg_hba.conf
   echo "host    all             all             127.0.0.1/32 md5" >> /var/lib/pgsql/data/pg_hba.conf
   #echo "listen_addresses='*'" >> /var/lib/pgsql/data/pg_hba.conf

   # php
   echo "update dateformat for php"
   echo "date.timezone = CET" > /etc/php.d/datetime.ini
   cd /libretime_src/libretime
   echo "install libretime please be patient ....."
   ./install -fiap
fi
