#!/bin/bash

# شناسایی توزیع سیستم‌عامل
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_NAME=$ID
    OS_VERSION=$VERSION_ID
else
    OS_NAME=$(uname -s)
    OS_VERSION=""
fi

# تابع نصب Docker براساس سیستم‌عامل
install_docker() {
    case $OS_NAME in
        "ubuntu")
            if [[ $(echo "$OS_VERSION >= 20.04" | bc) -eq 1 ]]; then
                sudo apt update
                sudo apt install -y docker.io
            else
                echo "Ubuntu version is below 20.04, Docker installation is not supported."
            fi
            ;;
        "debian")
            if [[ $(echo "$OS_VERSION >= 11" | bc) -eq 1 ]]; then
                sudo apt update
                sudo apt install -y docker.io
            else
                echo "Debian version is below 11, Docker installation is not supported."
            fi
            ;;
        "centos")
            if [[ $(echo "$OS_VERSION >= 8" | bc) -eq 1 ]]; then
                sudo yum install -y docker
            else
                echo "CentOS version is below 8, Docker installation is not supported."
            fi
            ;;
        "fedora")
            if [[ $(echo "$OS_VERSION >= 36" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "Fedora version is below 36, Docker installation is not supported."
            fi
            ;;
        "arch")
            sudo pacman -S --noconfirm docker
            ;;
        "manjaro")
            sudo pacman -S --noconfirm docker
            ;;
        "almalinux")
            if [[ $(echo "$OS_VERSION >= 8.0" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "AlmaLinux version is below 8.0, Docker installation is not supported."
            fi
            ;;
        "rocky")
            if [[ $(echo "$OS_VERSION >= 8" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "Rocky Linux version is below 8, Docker installation is not supported."
            fi
            ;;
        "oracle")
            if [[ $(echo "$OS_VERSION >= 8" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "Oracle Linux version is below 8, Docker installation is not supported."
            fi
            ;;
        *)
            echo "Unsupported OS: $OS_NAME"
            return 1
            ;;
    esac

    # فعال‌سازی و شروع Docker بعد از نصب
    sudo systemctl enable --now docker
}

# نصب Docker براساس شناسایی سیستم‌عامل
install_docker
