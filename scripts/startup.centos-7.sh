#!/bin/bash

sudo yum update -y
sudo yum install -y mc nano wget

# Install Ansible
sudo yum -y install epel-release
sudo yum -y install ansible

#install java amazon corretto JDK and JRE
#sudo wget https://d1f2yzg3dx5xke.cloudfront.net/java-1.8.0-amazon-corretto-devel-1.8.0_202.b08-1.amzn2.x86_64.rpm
sudo wget https://d1f2yzg3dx5xke.cloudfront.net/java-1.8.0-amazon-corretto-1.8.0_202.b08-1.amzn2.x86_64.rpm
sudo yum localinstall -y java-1.8.0-amazon-corretto*.rpm

#enable the Jenkins repository
sudo curl http://pkg.jenkins-ci.org/redhat/jenkins.repo --output /etc/yum.repos.d/jenkins.repo

#add the repository to system
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

#install the latest stable version of Jenkins
sudo yum -y install fontconfig
sudo yum -y upgrade && sudo yum -y install jenkins

#start the Jenkins service
sudo systemctl start jenkins

#enable the Jenkins service to start on system boot
sudo systemctl enable jenkins

sudo /sbin/chkconfig jenkins on

#install maven
sudo yum install maven -y

#download maven latest version
sudo wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -P /tmp

#Extract maven
sudo tar -xzf /tmp/apache-maven-3.6.0-bin.tar.gz -C /opt

sudo sed -i 's/<useSecurity>true/<useSecurity>false/' /var/lib/jenkins/config.xml

#create a symbolic link maven which will point to the Maven installation directory
sudo ln -s /opt/apache-maven-3.6.0 /opt/maven

#setup the environment variables
sudo cat <<EOF | sudo tee -a /etc/profile.d/maven.sh
  export JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64/jre
  export M2_HOME=/opt/maven
  export MAVEN_HOME=/opt/maven
  export PATH=\${M2_HOME}/bin:\${PATH}
EOF
sudo chmod +x /etc/profile.d/maven.sh

#load the environment variables
sudo source /etc/profile.d/maven.sh