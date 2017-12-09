#!/bin/bash

docker exec pxe-server bash -c "mount -t nfs -o nolock 10.10.40.9:/mnt/i2b-co-data9/isos /mnt && if [ ! -d /var/ftp/pub/centos7 ] ; then mkdir /var/ftp/pub/centos7; fi && mount -o loop /mnt/centos-7.iso /var/ftp/pub/centos7 && rm -rf /var/lib/tftpboot/centos7/initrd.img /var/lib/tftpboot/centos7/vmlinuz && cp /var/ftp/pub/centos7/images/pxeboot/initrd.img /var/lib/tftpboot/centos7/initrd.img  && cp /var/ftp/pub/centos7/images/pxeboot/vmlinuz /var/lib/tftpboot/centos7/vmlinuz"
