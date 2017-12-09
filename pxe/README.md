Docker PXE Server - CentOS 6/7
==============================


This project creates a `P`reboot e`X`ecution `E`nvironment Server, to boot machines from their `NIC`'s, allowing aoutomated installations only for `CentOS` `6` and `7`.

If you are running `VMWare ESXi` and want to automate your vm's installation process, this may help in conjuction with a custom kicstart file.

Note:
----
Remeber that a `PXE` will always use a central image to serve to the clients, so, your installtion is always going to be with the same image that is configured at the pxe server.

Requirements
------------

- Docker Engine installed.
- Docker Compose installed to automate the process.

How it works
------------

The servers is composed by some pieces of software, which are:


- A tftp server
- A slave dhcp server
- A xinetd process manager
- Some other complementary packages

How to create the server
=======================

If you want to create yor server, you should know a bit about networking, to define some needed variables.
These are listed below, and they all `MUST` be set at creation time, otherwise the server won't start.

- `SUBNET`: Define your local subnet
- `NETMASK`: Define your netmask
- `DHCP_RANGE`: Define the range where the dhcp server will assing IP's to the vm's using the pxe server. This is IP is only used during the installation. e.g: `DHCP_RANGE`: 10.10.0.240 10.10.0.250
- `DNS`: Define your primary DNS
- `GATEWAY`: Define your Gateway
- `BROADCAST`: Define your broadcast IP address.
- `PXE_SERVER_IP`: Define the IP where the PXE server will run. `MUST` be the same of the Docker Host.

These variables must be set at the `docker-compose.yml` file, like this:

Example docker-compose.yml
-------------------------

```
cat docker-compose.yml

    environment:
      - SUBNET=10.10.0.0
      - NETMASK=255.255.255.0
      - DHCP_RANGE=10.10.0.30 10.10.0.38
      - DNS=10.10.0.1
      - GATEWAY=10.10.0.1
      - BROADCAST=10.10.0.255
      - PXE_SERVER_IP=10.10.0.2
```


Runnig your server
=================

After you define all the required variables you just have to type:

```
docker-compose up -d
```
This must be done at the same level where the `docker-compose.yml` file is located. If you are in other folder, you have to specify the path of the file by using the `-f` flag.

After that, you will have your server up and running.


Integration with kickstart
==========================

Docker will create a folder at `/opt/ks` where you are supossed to put your kickstart file, with a name of `centos-7.cfg` or `centos-6.cfg`. You can always change the name of the ks file, at `files/default`, in the line where it says: 

```
ks=ftp://YOUR_PXE_SERVER/pub/centos-7.cfg
```

- Just change the name that suit your needs. Of course, this name has to match with filename that you put at `/opt/ks`.

- When the installation at the vm starts, depending on the label you choose, it will look for the file name defined at `files/default`.

- Do not forget defining the `url --url` parameter at your kickstart file, to specify the source files for installations.

We recomend you to use this mirror: `mirror.gtdinternet.com/7/os/x86_64/`, it is not publicity, it is just that the Docker Image uses the `initrd.img` and `vmlinuz` files from that source, and if you specify another mirror, there could be some problems.


How to use a different source for installation
==============================================

The recommended trick:
----------------------

If you want to use another mirror than the default, you can always build a new image with the mirror you prefer. For instance, you don't want to use the mirror that I mentioned above, instead, you want to use this: `http://mirrors.sonic.net/centos/6/os/x86_64`. Remember that the mirror you use, must be the same that resides on you PXE server.

To build a new image with a new mirror for centos 6, use:

```
docker build --rm --build-arg source_url6=http://mirrors.sonic.net/centos/6/os/x86_64/ -t pxe-server --no-cache .
```
To change the mirror for both, use:
```
docker build --rm --build-arg source_url6=http://mirrors.sonic.net/centos/6/os/x86_64/ --build-arg source_url7=http://mirrors.sonic.net/centos/7/os/x86_64/-t pxe-server --no-cache .
```

Now, just remember to use the same mirror in your kickstart file.

The local trick:
---------------

If you don't want to use that mirror, or maybe you want to use a local iso, you could do the following. (Take a look at the files/mount.sh script, this one does the trick)

- This changes are made at the container layer, so if the container is destroyed, you would have to it again, unless you add it to the CMD, which is not recommended.
- Create a script for future use.
- This cannot be done at docker build, because you need privileged permissions, and it is only allowed at container run time, not at build time.


If you want to use a nfs repo, you would:
```
docker exec pxe-server bash -c "mount -t nfs ${nfs-server}:${path-to-shared-folder} /mnt && if [ ! -d /var/ftp/pub/centos7 ] ; then mkdir /var/ftp/pub/centos7; fi && mount -o loop /mnt/${your-centos7.iso} /var/ftp/pub/centos7 && rm -rf /var/lib/tftpboot/centos7/initrd.img /var/lib/tftpboot/centos7/vmlinuz && cp /var/ftp/pub/centos7/images/pxeboot/initrd.img /var/lib/tftpboot/centos7/initrd.img  && cp /var/ftp/pub/centos7/images/pxeboot/vmlinuz /var/lib/tftpboot/centos7/vmlinuz"
```
Where:
- `${nfs-server}` is the IP of your nfs server.
- `${path-to-shared-folder}` is the shared path.
- `${your-centos7.iso}` is the name of your local centos iso.


Then, point the `--url` property at kickstart file to your `PXE-SERVER IP`, like this:
```
ftp://PXE-SERVER_IP/pub/centos7
```
That should do the trick. Now, you are using your local iso image.
