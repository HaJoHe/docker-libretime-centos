# DOCKER Container for running libretime (www.libretime.org)

# How to run? 
docker run -p 80:80 -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
 -d --privileged \
 --name libretime \ 
 hajo/docker-libretime-centos

# Not yet ready to use
