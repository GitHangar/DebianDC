#!/bin/bash

# -----------------------------------------------------------------------------
# STANDART PACKAGES
# -----------------------------------------------------------------------------
export DEBIAN_FRONTEND=noninteractive
apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

apt-get -y install git
apt-get -y install zenity
apt-get -y install openssh-server ntp
apt-get -y install tmux vim
apt-get -y install dnsutils net-tools
apt-get -y install curl wget
apt-get -y install ack expect krb5-user krb5-config
apt-get -y install htop
apt-get -y install ansible

# -----------------------------------------------------------------------------
# APPLICATION INSTALL & CONFIG
# -----------------------------------------------------------------------------
git clone https://github.com/eesmer/DebianDC.git

cp -R DebianDC/debiandc/ /usr/local/ && cp DebianDC/README.md /usr/local/debiandc/ && rm -r DebianDC
chown -R root:root /usr/local/debiandc
chmod -R 744 /usr/local/debiandc
chmod +x /usr/local/debiandc/manager
cp /usr/local/debiandc/manager /usr/sbin/
chmod 755 /usr/sbin/manager
chmod +x /usr/sbin/manager

# -----------------------------------------------------------------------------
# DESKTOP ENV: INSTALL
# -----------------------------------------------------------------------------
XDIR=FALSE
[ -d "/usr/share/xsessions/" ] && XDIR=TRUE
if [ "$XDIR" = "TRUE" ]; then
    [ "$(ls -A /usr/share/xsessions/)" ] && XDIR=FULL || XDIR=EMPTY
fi

if [ "$XDIR" = "FALSE" ] || [ "$XDIR" = "EMPTY" ; then
apt-get -y install lxde-core

mkdir -p /etc/skel/.local/share/applications
cat > /etc/skel/.local/share/applications/DebianDC-Manager.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=DebianDC-Manager
Terminal=false
Comment=Active Directory Manager
Categories=IDE
Icon=/usr/share/icons/gnome/48x48/actions/stock_up.png
Exec=bash /usr/local/debiandc/manager
EOF

mkdir -p /root/Desktop/DebianDC
cp /etc/skel/.local/share/applications/DebianDC-Manager.desktop /root/Desktop/DebianDC/
chmod +x /root/Desktop/DebianDC/DebianDC-Manager.desktop

mkdir -p /root/.local/share/applications/
cp /etc/skel/.local/share/applications/DebianDC-Manager.desktop /root/.local/share/applications/
chmod +x /root/.local/share/applications/DebianDC-Manager.desktop

# -----------------------------------------------------------------------------
# DebianDC IMAGE,LOGO
# ----------------------------------------------------------------------------
ADDRESS="http://www.esmerkan.com/debiandc"
sed -i '50aOS="DebianDC"' /etc/grub.d/10_linux
update-grub
wget -O /usr/share/lxde/images/logout-banner.png $ADDRESS/images/logout-banner.png
wget -O /usr/share/lxde/images/lxde-icon.png $ADDRESS/images/DebianDC-icon.png

echo "####################################"
echo "# DebianDC installation completed. #"
echo "####################################"
sleep 1
reboot
fi
