#!/bin/bash

error_msg="\033[41;37m"
success_msg="\033[32;40m"
reset="\033[0m"

check_os() {
    # Check if OS release is Ubuntu 20.04
    detected_os=$(lsb_release -d | awk '{print $2" "$3}')
    if [[ $(lsb_release -rs) == "20.04" ]]; then
        echo -e "${success_msg}Detected OS: $detected_os${reset}"
    else
        echo -e "${error_msg}Hojat tested me on Ubuntu 20.04 and 22.04, And your OS is $detected_os. Would you like to continue? (Y/n):${reset}"
        read -r answer
        if [[ $answer =~ ^[Nn]$ ]] ; then
            exit 1
        fi
    fi
}