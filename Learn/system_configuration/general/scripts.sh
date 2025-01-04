#Disable SELinux
sudo setenforce 0
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

#Disable firewallD
sudo systemctl stop firewalld
sudo systemctl disable firewalld

#Ip forward configuration
sudo sysctl -w net.ipv4.ip_forward=1


#root_username: lenn
#root_password: lenn