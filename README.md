# DOCKER Container for running libretime (www.libretime.org)

# How to run? 
docker run -p 80:80 -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
 -d --privileged \
 --name libretime \ 
 hajo/docker-libretime-centos

# Initialisierung
docker exec -it libretime /1stRun.sh

If installation has finished, do a config of libretime via Web

If done.. restart the container
docker restart libretime

# Not yet ready to use
