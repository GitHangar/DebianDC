# DebianDC
Domain Controller and Samba AD Graphic Interface Environment<br>
DebianDC provides a Domain Controller installation and graphical interface manage environment for Samba Active Directory.<br>
DebianDC installs a graphical interface called AD-Manager and manages the Active Directory environment with zenity screens.<br>

![alt text](screenshots/Screenshot-1.png "DebianDC Main Menu")
![alt text](screenshots/Screenshot-2.png "DebianDC User Management Menu")

## Features
- Domain and Domain Controller setup
- User Management
- Group Management
- DNS Management (BIN9_DLZ)
- OU Management (You can move AD accounts between Users and OUs -Currently only users)
- Reports (more detailed reports than the listing process)

## Requirements
desktop environment (mate, lxde etc.)<br>
*This work has been done on Debian distribution. (Debian10 buster)<br>

## Installation and Usage
```sh
$ wget https://raw.githubusercontent.com/eesmer/DebianDC/master/debiandc-installer.sh
$ bash debiandc-installer.sh
```
Use DebianDC and AD-Manager with root user
#### DC Setup
Run the server-setup command from the terminal screen
```sh
$ server-setup
```
#### AD-Manager
Run the manager command from the terminal screen
```sh
$ manager
```
