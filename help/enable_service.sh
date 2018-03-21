#!/bin/bash
#

# enable services
systemctl enable postgresql
systemctl enable rabbitmq-server
systemctl enable httpd
