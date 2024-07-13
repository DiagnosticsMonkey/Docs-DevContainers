#!/bin/bash

# Colour Codes
RED='\033[91m'
GREEN='\033[92m'
YELLOW='\033[93m'
BLUE='\033[94m'
PURPLE='\033[95m'
CYAN='\033[96m'
# Styles
UNDERLINE='\033[4m'
BOLD='\033[1m'
RESET='\033[0m'

# Script Variables
NewLn="\r\n"
Author="Diagnostics"
ScriptName="${0##*/}"
ExUsage="Usage: Run this script to install Docker in WSL2.${NewLn}   Example: ./${ScriptName}"

# --------------

# Functions for Error and Warning Handling
print_header() {
   echo -e "${PURPLE}${BOLD}$1${RESET}"
}

print_fatal_error() {
   echo -e "${RED}${BOLD}Fatal Error: $1${RESET}"
   exit 1
}

print_error() {
   echo -e "${RED}${BOLD}Error: $1${RESET}"
}

print_warning() {
   echo -e "${YELLOW}${BOLD}Warning: $1${RESET}"
}

print_success() {
   echo -e "${GREEN}${BOLD}$1${RESET}"
}

print_info() {
   echo -e "${BLUE}$1${RESET}"
}

print_separator() {
   echo -e "${CYAN}------------------------------------${RESET}"
}

# --------------

# Function to execute a command and handle errors
run_command() {
   cmd="$1"
   description="$2"
   
   print_info "${description}..."
   eval "${cmd}"
   
   if [ $? -ne 0 ]; then
      print_fatal_error "${description} failed."
   else
      print_success "${description} completed successfully."
   fi
}

# --------------

# We sudoed?
check_sudo() {
   if [ "$EUID" -ne 0 ]; then
      print_fatal_error "Permissions you don't have; sudo you must."
   fi
}

# --------------

# Main function
main() {
   # Author and Usage
   print_header "Script by: ${Author}${NewLn}   ${ExUsage}"

   check_sudo

   # Update the package list
   run_command "sudo apt-get update" "Updating the package list"

   # Install Docker
   run_command "sudo apt-get install -y docker.io" "Installing Docker"

   # Enable and start Docker service
   run_command "sudo systemctl enable docker" "Enabling Docker service"
   run_command "sudo systemctl start docker" "Starting Docker service"
   
   # Test hello-world
   run_command "docker run hello-world" "Attempting the run example"
   
   print_success "Script reached the end."
}

main "$@"