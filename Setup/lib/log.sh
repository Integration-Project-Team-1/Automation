#!/bin/bash
#
# Dit script definieert functies om te loggen
#
# Voor system logs zie:
# /var/log/

log_file="./log.txt"

write_log() {
    local message="$1"
    local timestamp
    # Voeg tijdsvermelding en gebruiker toe aan het bericht.
    timestamp=$(date +"%Y - %m -%d %T")
    local formatted_message="[$timestamp] : $USER - $message"

    # Schrijf het bericht naar het log bestand.
    echo -e "$formatted_message" >> "$log_file"
}

print_and_log() {
    local msg="$1"
    write_log "$msg"
    echo -e "$msg"
}
