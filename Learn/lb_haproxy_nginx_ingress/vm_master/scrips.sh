sudo -i
apt install haproxy -y
apt install keepalived -y
apt install rsyslog -y

sudo -i

#Configure rsyslog for HAProxy
cd /etc/rsyslog.d
touch haproxy.conf
vim haproxy.conf

# Collect log with UDP
$ModLoad imudp
$UDPServerAddress 127.0.0.1
$UDPServerRun 514

# Creating separate log files based on the severity
local0.* /var/log/haproxy-traffic.log
local0.notice /var/log/haproxy-admin.log

# Restart rsyslog
systemctl restart rsyslog

#Configure Keepalived for HAProxy
cd /etc/keepalived
touch keepalived.conf
vim keepalived.conf

#Check for network interface by cmd ip a
#Priority will change by difference master node 100 - master1; 99 - master2; 98 - master3
#State will change by difference master node MASTER - master1; BACKUP - master2; BACKUP - master3

# vrrp_script haproxy-check {
#     script "killall -0 haproxy"
#     interval 2
#     weight 10
# }

# vrrp_instance kubernetes {
#     state MASTER
#     priority 100
#     interface ens33
#     virtual_router_id 61
#     advert_int 2
#     authentication {
#         auth_type AH
#         auth_pass lenn
#     }
#     virtual_ipaddress {
#         192.168.217.10
#     }

#     track_script {
#         haproxy-check
#     }
# }

#Restart Keepalived
systemctl restart keepalived