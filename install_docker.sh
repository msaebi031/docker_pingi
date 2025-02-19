#!/bin/bash

# شناسایی توزیع سیستم‌عامل از دستور lsb_release
OS_NAME=$(lsb_release -i | awk '{print $3}')
OS_VERSION=$(lsb_release -r | awk '{print $2}')

# تابع نصب Docker براساس سیستم‌عامل
install_docker() {
    case $OS_NAME in
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
        "Fedora")
            if [[ $(echo "$OS_VERSION >= 36" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "Fedora version is below 36, Docker installation is not supported."
            fi
            ;;
        "Arch")
            sudo pacman -S --noconfirm docker
            ;;
        "Manjaro")
            sudo pacman -S --noconfirm docker
            ;;
        "AlmaLinux")
            if [[ $(echo "$OS_VERSION >= 8.0" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "AlmaLinux version is below 8.0, Docker installation is not supported."
            fi
            ;;
        "Rocky")
            if [[ $(echo "$OS_VERSION >= 8" | bc) -eq 1 ]]; then
                sudo dnf install -y docker
            else
                echo "Rocky Linux version is below 8, Docker installation is not supported."
            fi
            ;;
        "Oracle")
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
