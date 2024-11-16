#!/bin/bash

echo


echo "@$(uname -n)"
echo "_____________________________________________"

# Get OS details
echo "Operating System (OS): $(grep -oP '(?<=^PRETTY_NAME=).*' /etc/os-release | tr -d '"')"

# Host
hostnamectl | awk '{$1=$1} /Hardware Model/'

# Kernel version
echo "Linux version: $(uname -sr)"

# Uptime
echo "Uptime: $(uptime -p)"

# Package Managers
echo -e "Package Managers: $(apt --version 2>/dev/null || echo "" ; dnf --version 2>/dev/null || echo "" ; yum --version 2>/dev/null || echo "" ; pacman -Q pacman 2>/dev/null || echo "" ; zypper --version 2>/dev/null || echo "" ; snap --version 2>/dev/null || echo "" ; flatpak --version 2>/dev/null || echo "" ; brew --version 2>/dev/null || echo "" ; nix-env --version 2>/dev/null || echo "" ; fink --version 2>/dev/null || echo "" ; guix --version 2>/dev/null || echo "" ; port version 2>/dev/null || echo "")" | sed '/^$/d' | tr '\n' ' ' | sed 's/ *$//'

# Break
echo

# Bash version
echo "Bash Version: $(bash --version | awk '/GNU bash/ {print $4}')"

# Monitor resolution
hwinfo --monitor | awk '/Resolution.*Hz/ {gsub(/^[ \t]*/, "", $0); print $0}'

# Desktop Environment
echo "Desktop Environment (DE): $XDG_CURRENT_DESKTOP"

# Windows Manager
echo "Windows Manager (WM): $(ps -e | grep -E 'i3|kwin|mutter|openbox|xfwm4|compiz|awesome|dwm|bspwm' | awk 'NR==2 {print $4}')"

# Terminal Emulator
echo "Terminal Emulator $(ps -p $$ -o ppid= | xargs -I {} ps -p {} -o comm=)"

# CPU information
echo "Central Processing Unit (CPU): $(awk -F: '/model name/ {print $2}' /proc/cpuinfo | head -n 1 | xargs)"

# GPU information
echo "Graphics Processing Unit (GPU): $(lspci | grep -i vga | sed 's/.*: //')"

# Memory Usage
echo "Memory: $(free -h | awk '/Mem:/ {print $3 "/" $2}')"

# Distro release
#echo "Distro Release: $(lsb_release -r | awk '{$1=$1; print $2}')"

# Pause for spacing
echo

# Colors block
for color in {40..47}; do
    echo -ne "\033[${color}m  \033[0m"
done
echo

# User info
#echo "User: $(whoami)"

# IP Address
#echo "Internet Protocol (IP): $(hostname -i | awk '{print $1}')"

# SSD or HDD
#echo "SSD/HDD: $(lsblk -d -o name,rota,type,model | awk '!/NAME/ {$1=$1; print} ')"
