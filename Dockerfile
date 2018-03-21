# 
# Dockerfile based on work of https://hub.docker.com/_/ubuntu-upstart/
# and inspired by https://github.com/okvic77/docker-airtime
#
FROM centos:7

MAINTAINER Hans-Joachim dd8ne@web.de

ENV container docker

#
# Install OS Stuff
#
COPY help/* /
RUN /prep_os.sh

# Clean up systemd 
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

#
# Enable services
#
RUN /enable_service.sh

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]



