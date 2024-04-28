#!/bin/bash
#
# Dit script definieert functies om te loggen
#
# Voor system logs zie:
# /var/log/

# Logt een bericht
# param1: log_file: het pad naar de log file
# param2: message: het bericht
write_log() {
    local log_file="$1"
    local message="$2"
    local timestamp
    # Voeg tijdsvermelding en gebruiker toe aan het bericht.
    timestamp=$(date +"%Y - %m -%d %T")
    local formatted_message="[$timestamp] : $USER - $message"

    # Schrijf het bericht naar het log bestand.
    echo -e "$formatted_message" >> "$log_file"
}

# Print een bericht en logt naar een file
# param1: log_file: het pad naar de log file
# param2: message: het bericht
print_and_log() {
    local log_file="$1"
    local message="$2"
    write_log "$log_file" "$message"
    echo -e "$message"
}
