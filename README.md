# DOCKER Container for running libretime (www.libretime.org)

## How to run? 
docker run -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
 -v /tmp/$(mktemp -d):/run \
 -v /srv/libretime_centos/stor:/srv/airtime/stor \
 -v /srv/libretime_centos/watch:/srv/airtime/watch \
 -v /srv/libretime_centos/postgresql:/var/lib/pgsql/data \
 -v /srv/libretime_centos/etc:/etc/airtime \
 -p 80:80 -p 8000-8005:8000-8005 --name libretime \
 -d hajo/docker-libretime-centos

### Initialisierung
docker exec -it libretime /1stRun.sh

If installation has finished, do a config of libretime via Web

If done.. restart the container
docker restart libretime

# Not yet ready to use
