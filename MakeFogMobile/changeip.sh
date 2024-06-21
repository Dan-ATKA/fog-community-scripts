#/bin/bash
ip addr flush dev enp0s3
dhclient enp0s3 -v
ip4=$(/sbin/ip -o -4 addr list enp0s3 | awk '{print $4}' | cut -d/ -f1)
echo $ip4
cp ltsp.conf.template /etc/dnsmasq.d/ltsp.conf
sed -i -r 's/Dan Rulz!/Dan kicks ass/g' /etc/dnsmasq.d/ltsp.conf
sed -i -r 's/<fog_server_IP>/'"${ip4}"'/g' /etc/dnsmasq.d/ltsp.conf
cp fogsettings.template /opt/fog/.fogsettings
sed -i -r 's/<ip_serveur>/'"${ip4}"'/g' /opt/fog/.fogsettings
cp default.ipxe.template /tftpboot/default.ipxe
sed -i -r 's/<ip_serveur>/'"${ip4}"'/g' /tftpboot/default.ipxe
service dnsmasq restart
service dnsmasq status
#service apache2 restart
#service apache2 status
