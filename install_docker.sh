#!/bin/bash

# Get the operating system name and version
OS_NAME=$(uname -s)
OS_VERSION=$(lsb_release -rs 2>/dev/null)

# Function to install Docker based on the OS
install_docker() {
    case $1 in
        "Ubuntu")
            if [[ $(echo "$OS_VERSION >= 20.04" | bc) -eq 1 ]]; then
                sudo apt update
                sudo apt install -y docker.io
            else
                echo "Ubuntu version is below 20.04, Docker installation is not supported."
            fi
            ;;
        "Debian")
            if [[ $(echo "$OS_VERSION >= 11" | bc) -eq 1 ]]; then
                sudo apt update
                sudo apt install -y docker.io
            else
                echo "Debian version is below 11, Docker installation is not supported."
            fi
            ;;
        "CentOS")
            if [[ $(echo "$OS_VERSION >= 8" | bc) -eq 1 ]]; then
                sudo yum install -y docker
            else
                echo "CentOS version is below 8, Docker installation is not supported."
            fi
            ;;
        "OpenEuler")
            if [[ $(echo "$OS_VERSION >= 22.03" | bc) -eq 1 ]]; then
                sudo yum install -y docker
            else
                echo "OpenEuler version is below 22.03, Docker installation is not supported."
            fi
            ;;
        "Fedora")
            if [[ $(echo "$OS_VERSION >= 36" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "Fedora version is below 36, Docker installation is not supported."
            fi
            ;;
        "Arch Linux")
            sudo pacman -S --noconfirm docker
            ;;
        "Parch Linux")
            sudo pacman -S --noconfirm docker
            ;;
        "Manjaro")
            sudo pacman -S --noconfirm docker
            ;;
        "Armbian")
            sudo apt update
            sudo apt install -y docker.io
            ;;
        "AlmaLinux")
            if [[ $(echo "$OS_VERSION >= 8.0" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "AlmaLinux version is below 8.0, Docker installation is not supported."
            fi
            ;;
        "Rocky Linux")
            if [[ $(echo "$OS_VERSION >= 8" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "Rocky Linux version is below 8, Docker installation is not supported."
            fi
            ;;
        "Oracle Linux")
            if [[ $(echo "$OS_VERSION >= 8" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "Oracle Linux version is below 8, Docker installation is not supported."
            fi
            ;;
        "OpenSUSE Tumbleweed")
            sudo zypper install -y docker
            ;;
        "Amazon Linux")
            if [[ $(echo "$OS_VERSION >= 2023" | bc) -eq 1 ]]; then
                sudo yum install -y docker
            else
                echo "Amazon Linux version is below 2023, Docker installation is not supported."
            fi
            ;;
        "Windows")
            if [[ $(arch) == "x86_64" ]]; then
                echo "Please download Docker Desktop for Windows from Docker's website."
            else
                echo "Windows version is not supported for Docker installation."
            fi
            ;;
        *)
            echo "Unsupported OS: $OS_NAME"
            ;;
    esac
}

# Check the OS and install Docker
install_docker "$OS_NAME"

# Enable and start Docker service
sudo systemctl enable --now docker
