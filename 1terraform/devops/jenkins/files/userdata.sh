#!/bin/bash
#
# Install Java 1.8.0_181
#
apt-get update -y
apt-get install openjdk-8-jre-headless -y
#
# Create EFS mount folder & mount
#
apt-get install nfs-common -y
mkdir /efsmnt
mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dnsname}:/ /efsmnt
echo '${efs_dnsname}:/ /efsmnt nfs defaults,_netdev 0 0' >> /etc/fstab
#
# Install Jenkins
#
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo 'deb https://pkg.jenkins.io/debian-stable binary/' > /etc/apt/sources.list.d/jenkins.list
apt-get update -y 
apt-get install jenkins -y
service jenkins stop
#
# Mount JENKINS_HOME -> EFS
#
sed -i '/JENKINS_HOME/c\JENKINS_HOME=/efsmnt' /etc/default/jenkins
# Lets ensure state: 
#   * EFS mounted
#   * Mounts are all working
#   * Jenkins user and group own /efsmnt
#
chown jenkins:jenkins /efsmnt
mount -a
service jenkins start
