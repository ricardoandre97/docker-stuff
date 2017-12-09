FROM centos

ARG source_url6="http://mirror.gtdinternet.com/6/os/x86_64"
ARG source_url7="http://mirror.gtdinternet.com/7/os/x86_64"

# Package installation

RUN \ 
yum install -y     \
  dhcp             \
  xinetd           \
  tftp-server      \
  syslinux         \
  nfs-utils        \
  vsftpd        && \
  yum clean all

# Server configuration

RUN \
  cp /usr/share/syslinux/pxelinux.0 /var/lib/tftpboot && \
  cp /usr/share/syslinux/menu.c32   /var/lib/tftpboot && \
  cp /usr/share/syslinux/memdisk    /var/lib/tftpboot && \
  cp /usr/share/syslinux/mboot.c32  /var/lib/tftpboot && \
  cp /usr/share/syslinux/chain.c32  /var/lib/tftpboot && \
  mkdir \
    /var/lib/tftpboot/pxelinux.cfg \
    /var/lib/tftpboot/centos6      \
    /var/lib/tftpboot/centos7   && \
  curl -vo \
    /var/lib/tftpboot/centos6/vmlinuz \
    ${source_url6}/images/pxeboot/vmlinuz && \
  curl -vo \
    /var/lib/tftpboot/centos6/initrd.img \
    ${source_url6}/images/pxeboot/initrd.img && \
  curl -vo \ 
    /var/lib/tftpboot/centos7/vmlinuz \
    ${source_url7}/images/pxeboot/vmlinuz && \
  curl -vo \
    /var/lib/tftpboot/centos7/initrd.img \ 
    ${source_url7}/images/pxeboot/initrd.img

WORKDIR /var/lib/tftpboot

COPY files/start.sh /

CMD /start.sh
