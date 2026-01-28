#!/bin/bash

print_message() {
    printf "\n========================================\n"
    printf "%s\n" "$1"
    printf "========================================\n\n"
}

# detecting OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macOS"
        PKG_MANAGER="brew"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="Linux"
        PKG_MANAGER="apt-get"
    else
        OS="Unknown"
        PKG_MANAGER="unknown"
    fi
    print_message "Detected OS: $OS"
}

# check python
check_python() {
    print_message "Checking for Python3..."
    
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version)
        print_message "Python3 is already installed: $PYTHON_VERSION"
    else
        print_message "Python3 not found. Installing..."
        if [[ "$OS" == "macOS" ]]; then
            brew install python3
        elif [[ "$OS" == "Linux" ]]; then
            sudo apt-get update
            sudo apt-get install -y python3
        fi
        print_message "Python3 installation complete"
    fi
}


# Verify pip is available
check_pip() {
    print_message "Checking for pip..."
    
    if command -v pip3 &> /dev/null; then
        PIP_VERSION=$(pip3 --version)
        print_message "pip is available: $PIP_VERSION"
    else
        print_message "pip not found. This is unusual after Python installation."
    fi
}


# Install Jupyter Notebook
install_jupyter() {
    print_message "Installing Jupyter Notebook..."
    
    if [[ "$OS" == "macOS" ]]; then
        pip3 install jupyter
    elif [[ "$OS" == "Linux" ]]; then
        pip3 install jupyter
    fi
    
    print_message "Jupyter Notebook installation complete"
}


# macOS-specific: Check Homebrew health
check_brew_health() {
    if [[ "$OS" == "macOS" ]]; then
        print_message "Running Homebrew diagnostics..."
        brew doctor
    fi
}

print_message "Starting Development Environment Setup" 
detect_os
check_python
check_pip
install_jupyter
check_brew_health
print_message "Setup Complete! Your development environment is ready."
