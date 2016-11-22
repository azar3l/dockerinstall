#!/bin/bash
#author "ankit"
echo "this will install docker in ubuntu $(lsb_release -r -s)"
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates -y
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#need to add conditions here so it can work on any ubuntu version
rel=$(lsb_release -r -s)
#checking ubuntu version and adding repo list only works with version >=14.04 & 16.04
#need to add test condition here
#if [ $rel >= 14.04 && $rel <= 16.04 ]
#then
case $rel in
	16.04 )
		echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
		;;
	15.10 )
		echo "deb https://apt.dockerproject.org/repo ubuntu-wily main" | sudo tee /etc/apt/sources.list.d/docker.list
		;;
	14.04 )
		echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
		;;
esac
#else 
	#echo " docker works better with ubuntu version between 14.04 and 16.04"
#fi
sudo apt-get update
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual -y
sudo apt-get install docker-engine -y
sudo service docker start
sudo docker run hello-world
echo "adding docker group to your current user"
sudo usermod -aG docker $USER
echo "do you need to reboot"
echo "press y/Y for yes"
#asking for user permission to reboot , only Y/y should work
read -p "" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	exec /sbin/reboot > /dev/null 
    #sudo reboot && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi
