#! /bin/bash

yum update -y
yum -y install httpd
systemctl start httpd
systemctl enable httpd
