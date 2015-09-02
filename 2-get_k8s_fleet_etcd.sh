#!/bin/bash

ssh-add

# Install/update etcdctl, fleetctl and kubectl

# fetch from settings file
master_name=kmaster

# get master external IP
master_ip=10.0.1.150
# path to the folder where we store our binary files
export PATH=${HOME}/k8s-bin:$PATH

# get latest k8s version
function get_latest_version_number {
local -r latest_url="https://storage.googleapis.com/kubernetes-release/release/latest.txt"
if [[ $(which wget) ]]; then
  wget -qO- ${latest_url}
elif [[ $(which curl) ]]; then
  curl -Ss ${latest_url}
fi
}

k8s_version=$(get_latest_version_number)

# create tmp folder
mkdir tmp

echo "Downloading and instaling fleetctl, etcdctl and kubectl ..."
# First let's check which OS we use: OS X or Linux
uname=$(uname)
# Linux
#
mkdir ~/k8s-bin
cd ./tmp
# download etcd and fleet clients for Linux
ETCD_RELEASE=$(etcdctl --version | cut -d " " -f 3- | tr -d '\r')
echo "Downloading etcdctl $ETCD_RELEASE for Linux"
curl -L -o etcd.tar.gz "https://github.com/coreos/etcd/releases/download/v$ETCD_RELEASE/etcd-v$ETCD_RELEASE-linux-amd64.tar.gz"
tar -zxvf etcd.tar.gz etcd-v$ETCD_RELEASE-linux-amd64/etcdctl
mv -f etcd-v$ETCD_RELEASE-linux-amd64/etcdctl ~/k8s-bin
# clean up
rm -f etcd.tar.gz
rm -rf etcd-v$ETCD_RELEASE-linux-amd64
echo "etcdctl was copied to ~/k8s-bin"
echo " "

FLEET_RELEASE=$(fleetctl version | cut -d " " -f 3- | tr -d '\r')
cd ./tmp
echo "Downloading fleetctl v$FLEET_RELEASE for Linux"
curl -L -o fleet.tar.gz "https://github.com/coreos/fleet/releases/download/v$FLEET_RELEASE/fleet-v$FLEET_RELEASE-linux-amd64.tar.gz"
tar -zxvf fleet.tar.gz fleet-v$FLEET_RELEASE-linux-amd64/fleetctl
mv -f fleet-v$FLEET_RELEASE-linux-amd64/fleetctl ~/k8s-bin
# clean up
rm -f fleet.tar.gz
rm -rf fleet-v$FLEET_RELEASE-linux-amd64
echo "fleetctl was copied to ~/k8s-bin"

# download kubernetes kubectl for Linux
echo "Downloading kubernetes $k8s_version kubectl for Linux"
curl -L -o kubectl https://storage.googleapis.com/kubernetes-release/release/$k8s_version/bin/linux/amd64/kubectl
mv -f kubectl ~/k8s-bin
echo "kubectl was copied to ~/k8s-bin"
echo " "

#
# Make them executable
chmod +x ~/k8s-bin/*
#
cd ..
