#!/bin/bash

##################
##### COLORS #####
##################
clear
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
BOLD=$(tput bold)
RESET=$(tput sgr0)

#####################
##### VARIABLES #####
#####################
choice=""
current_user=$(whoami)

##############################
##### SECURITY / CONTROL #####
##############################
if [ "$current_user" == "www-data" ]; then
    echo -e "${RED}This script should not be run as www-data.${RESET}"
    echo -e "${YELLOW}Please exit with 'exit' and run again as a regular user.${RESET}"
    exit 1
fi

handle_interrupt() {
    echo -n -e "${RESET}"
    echo -e "${BOLD}# ${RED}Interrupt detected${RESET} #${BOLD}\n"
    exit 1
}
trap handle_interrupt SIGINT

run_as_www_data() {
    # For commands that need to be run as www-data (e.g., web server actions)
    chown -R www-data:www-data /var/www/
    sudo -u www-data bash -c "$1"
}

########################
##### MENU OPTIONS #####
########################
show_options() {
    echo -e "\n ${BOLD}# ${BLUE}WHAT DO YOU WANT TO DO?${RESET} ${BOLD}#${RESET}\n"
    echo "  ${YELLOW}1${RESET} - Action 1 (example)"
    echo "  ${YELLOW}2${RESET} - Action 2 (example)"
    echo "  ${YELLOW}3${RESET} - Action 3 (example)"
    echo "      ------------"
    echo "  ${YELLOW}0${RESET} - ${RED}Exit${RESET}"
}

############################
##### ACTION FUNCTIONS #####
############################

action_1() {
    echo "${GREEN}[Action 1 executed]${RESET}"
}

action_2() {
    echo "${GREEN}[Action 2 executed]${RESET}"
}

action_3() {
    echo "${GREEN}[Action 3 executed]${RESET}"
}

##########################
##### MAIN MENU LOOP #####
##########################
main_menu() {
    while true; do
        show_options
        read -p "$(echo -e ${GREEN}Enter your choice: ${RESET}${YELLOW})" choice
        echo -n -e "${RESET}"
        echo -e "\n"

        case "$choice" in
            1) action_1 ;;
            2) action_2 ;;
            3) action_3 ;;
            0)
                clear
                echo -e "${GREEN}Script ended. See you soon, ${current_user}.${RESET}"
                exit 0
                ;;
            *) echo -e "${RED}Invalid choice. Please try again.${RESET}" ;;
        esac
        echo ""
    done
}

#########################
##### LAUNCH SCRIPT #####
#########################
main_menu