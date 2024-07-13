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
ScriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ExUsage="Usage: Run this script to launch the PowerShell setup.${NewLn}   Example: ./${ScriptName}"
LogFile="$ScriptDir/launch_powershell.log"

# --------------

# Functions for Error and Warning Handling
print_header() {
   echo -e "${PURPLE}${BOLD}$1${RESET}"
}

print_fatal_error() {
   echo -e "${RED}${BOLD}Fatal Error: $1${RESET}"
   echo "Fatal Error: $1" >> "$LogFile"
   exit 1
}

print_error() {
   echo -e "${RED}${BOLD}Error: $1${RESET}"
   echo "Error: $1" >> "$LogFile"
}

print_warning() {
   echo -e "${YELLOW}${BOLD}Warning: $1${RESET}"
   echo "Warning: $1" >> "$LogFile"
}

print_success() {
   echo -e "${GREEN}${BOLD}$1${RESET}"
   echo "$1" >> "$LogFile"
}

print_info() {
   echo -e "${BLUE}$1${RESET}"
   echo "$1" >> "$LogFile"
}

print_separator() {
   echo -e "${CYAN}------------------------------------${RESET}"
   echo "------------------------------------" >> "$LogFile"
}

# --------------

# Function to check if running as administrator
is_admin() {
   NET SESSION > /dev/null 2>&1
   return $?
}

# Function to relaunch script with administrator privileges
run_as_admin() {
   local scriptPath
   scriptPath=$(cygpath -w "$ScriptDir/setup_wsl.ps1")
   powershell.exe -Command "Start-Process 'powershell.exe' -ArgumentList '-NoExit -NoProfile -ExecutionPolicy Bypass -File \"$scriptPath\"' -Verb RunAs" >> "$LogFile" 2>&1
}

# --------------

# Main function
main() {
   # Clear the log file
   > "$LogFile"

   # Author and Usage
   print_header "Script by: ${Author}${NewLn}   ${ExUsage}"

   # Check if running as administrator
   if ! is_admin; then
      print_warning "This script requires administrator privileges. Relaunching with elevated permissions..."
      run_as_admin
   fi

   print_success "Launched PowerShell script with elevated privileges."
}

main "$@"
