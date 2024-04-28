#!/bin/bash

source log.sh

# Maakt een groep aan en schrijft een log en confirmatie bericht.
# param1: group: een groep om aan te maken
create_groups() {
	local group="$1"
	local msg_created="\e[32mGroup '$group' created\e.[0m"
	# Maak de groep
	sudo groupadd "$group"
	# Schrijf log en confirmatie
	print_and_log "$msg_created"
}

# Controleerd of groepen bestaan op het systeem.
# Maakt groepen aan en vraagt de gebruiker om confirmatie.
# Kan de confirmatie overslaan met a) all optie.
# param[@]: groups: een lijst met groepen om aan te maken
confirm_and_create_groups() {
	local groups=("$@")
	# State variabele om alle groepen al dan niet aan te maken:
	# - 0 : vragen voor confirmatie
	# - 1 : aanmaken zonder confirmatie
	local create_all_groups=0

	msg_start="Checking to create groups: ${groups[*]}"
	print_and_log "$msg_start"

	for group in "${groups[@]}"; do
		# Sla over indien de groep bestaat.
		if getent group "$group" >/dev/null; then
			local msg_exists="\e[32mGroup '$group' exists.\e[0m"
			print_and_log "$msg_exists"
			continue
		fi

		# Controleer of de prompt moet worden uitgevoerd.
		if [ $create_all_groups -eq 0 ]; then
			# Vraag confirmatie aan de gebruiker.
			read -rp "Group '$group' does not exist. Do you want to create it? (y/n/a for all): " choice
			case "$choice" in
			y|Y)
				create_group "$group"
				;;
			a|A)
				# Verander de state variabele om user confirmatie te stoppen voor de volgende iteraties.
				create_all_groups=1
				create_group "$group"
				;;
			*)
				local msg_skip="\e[33mSkipping group '$group'.\e[0m"
				print_and_log "$msg_skip"
				;;
			esac
		# Sla de confirmatie over
		else
			create_group "$group"
		fi
	done
}
