#!/usr/bin/env sh
#
# Dit lib script definieert logica voor het beheren van groepen.

source log.sh

# Controleerd of groepen bestaan op het systeem.
# Maakt groepen aan en schrijft berichten.
#
# arg1: log_file; Een pad naar een bestand om naar te loggen.
# arg[*]: group; Een lijst met groepen om aan te maken.
check_and_create_groups() {
	local log_file="$1"
	shift
	local groups=("$@")

	print_and_log "$log_file" "Checking to create groups: ${groups[*]}"

	for group in "${groups[@]}"; do
		# Controleer of de groep al bestaat.
		if getent group "$group" >/dev/null; then
			print_and_log "$log_file" "\e[32mGroup '$group' exists.\e[0m"
			continue
		fi
		# Maak de groep
		sudo groupadd "$group"
		# Controleer of de groep is aangemaakt
		if getent group "$group" >/dev/null; then
			print_and_log "$log_file" "\e[32mGroup '$group' created\e.[0m"
			return
		fi
		# Schrijf een bericht indien de groep niet aangemaakt is.
		print_and_log "\e[31mCould not create Group: $group\e[0m"
	done
}

# Voegt gebruikers to aan een groep
# Controleert of de gebruiker bestaat en in een groep zit.
# Print en logt berichten
#
# arg1: group; De groep om de gebruiker aan toe te voegen.
# arg2: log_file; Een pad naar een bestand om naar te loggen.
# arg[*]: users; Een lijst van gebruikers die de nieuwe groep moeten krijgen.
check_and_add_users_to_group() {
	local group="$1"
	shift
	local log_file="$1"
	shift
	local users=("$@")

	for user in "${users[@]}"; do
		# Controleer of de gebruiker bestaat
		if ! id "$user" &>/dev/null; then
			print_and_log "$log_file" "\e[33mUser: '$user' does not exist. - Skipping.\e[0m"
			continue
		fi
		# Controleer of de groep al bestaat.
		if ! getent group "$group" >/dev/null; then
			print_and_log "$log_file" "\e[32mGroup '$group' does not exist - Skipping.\e[0m"
			continue
		fi
		# Controleer of de gebruiker al in de groep zit
		if groups "$user" | grep -q "$group"; then
			print_and_log "$log_file" "\e[32mUser: '$user' is already a member of Group: '$group'. - Done\e[0m"
			continue
		fi
		sudo usermod -aG "$group" "$user"
		print_and_log "$log_file" "\e[32mUser: '$user' added to Group: '$group'. - Done\e[0m"
	done
}
