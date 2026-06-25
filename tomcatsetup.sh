#!/bin/bash

set -e

cd /opt/
sudo yum install java -y
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.119/bin/apache-tomcat-9.0.119.tar.gz
tar -xvf apache-tomcat-9.0.119.tar.gz 
/opt/apache-tomcat-9.0.119/bin/startup.sh
ps -ef | grep tomcat | awk -F" " '{print $2}' | head -1
