#!/bin/bash

cp -f /tmp/dhcpd /etc/dhcp/dhcpd.conf
cp -f /tmp/default /var/lib/tftpboot/pxelinux.cfg/default

vars=( "$SUBNET" "$NETMASK" "$DHCP_RANGE" "$DNS" "$GATEWAY" "$BROADCAST" "$PXE_SERVER_IP" )
dummy_words=( "YOUR_SUBNET" "YOUR_NETMASK" "DHCP_RANGE" "YOUR_DNS_SERVER" "YOUR_GATEWAY" "YOUR_BROADCAST" "YOUR_PXE_SERVER" )

for i in ${!vars[*]}; do 

  if [ -z "${vars[$i]}" ]; then
   echo "We found an empty variable."
   echo "Please, ensure all variables are set when creating the container. Can be at docker run or at docker-compose.yml"
   echo "Exiting..."
   exit 1
  else
   sed -i "s/${dummy_words[$i]}/${vars[$i]}/g" "/etc/dhcp/dhcpd.conf"
  fi

done

sed -i "s/YOUR_PXE_SERVER/$PXE_SERVER_IP/g" "/var/lib/tftpboot/pxelinux.cfg/default"

/usr/sbin/xinetd -stayalive -pidfile /var/run/xinetd.pid 
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
/usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid
