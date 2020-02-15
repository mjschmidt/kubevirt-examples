echo "Installing vim xrdp and htop"
dnf install -y vim xrdp htop
systemctl enable xrdp
systemctl start xrdp
echo
echo
echo
echo "Installing Cinnamon Desktop"
dnf groupinstall -y "Cinnamon Desktop" --allowerasing
systemctl set-default graphical.target
echo Rebooting
reboot

#Available Environment Groups:
#   Fedora Custom Operating System
#   Minimal Install
#   Fedora Server Edition
#   Fedora Workstation
#   KDE Plasma Workspaces
#   Xfce Desktop
#   LXDE Desktop
#   LXQt Desktop
#   Cinnamon Desktop
#   MATE Desktop
#   Sugar Desktop Environment
#   Deepin Desktop
#   Development and Creative Workstation
#   Web Server
#   Infrastructure Server
#   Basic Desktop
#Installed Environment Groups:
#   Fedora Cloud Server
#Available Groups:
#   Neuron Modelling Simulators
#   3D Printing
#   Administration Tools
#   Audio Production
#   Authoring and Publishing
#   Books and Guides
#   C Development Tools and Libraries
#   Cloud Infrastructure
#   Cloud Management Tools
#   Compiz
#   Container Management
#   D Development Tools and Libraries
#   Design Suite
#   Development Tools
#   Domain Membership
#   Fedora Eclipse
#   Editors
#   Educational Software
#   Electronic Lab
#   Engineering and Scientific
#   FreeIPA Server
#   Games and Entertainment
#   Headless Management
#   LibreOffice
#   MATE Applications
#   Medical Applications
#   Milkymist
#   Network Servers
#   Office/Productivity
#   Python Classroom
#   Python Science
#   Robotics
#   RPM Development Tools
#   Security Lab
#   Sound and Video
#   System Tools
#   Text-based Internet
#   Window Managers
