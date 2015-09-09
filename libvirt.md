## Create VM in libvirt
virt-install --name=centos --disk path=/var/lib/libvirt/images/centos2.dsk,size=16,sparse=true,cache=none,bus=scsi --graphics none --vcpus=2 --ram=2048 --network bridge=virbr0 --os-type=linux --os-variant=rhel7 --controller type=scsi,model=virtio-scsi --cdrom /var/lib/libvirt/images/CentOS-7-x86_64-Minimal-1503-01.iso
virt-install --name=centos --disk path=/var/lib/libvirt/images/centos2.dsk,size=11,sparse=true,cache=none,bus=scsi --graphics vnc --vcpus=2 --ram=2048 --network bridge=virbr0 --os-type=linux --controller type=scsi,model=virtio-scsi --cdrom /var/lib/libvirt/images/CentOS-7-x86_64-Minimal-1503-01.iso