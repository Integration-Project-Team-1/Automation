#!/bin/bash
#
# Dit lib script bevat logica om gebruikers te beheren.

source ./lib/log.sh

# Maakt nieuwe gebruikers aan.
#
# arg1: log_file; Een pad naar een bestand om naar te loggen.
# arg[*]: users; Een lijst van gebruikers om aan te maken.
create_users() {
    local log_file="$1"
    shift
	local users=("$@")
	for user in "${users[@]}"; do
		# Controleer of de gebruiker bestaat
		if id "$user" &>/dev/null; then
			print_and_log "$log_file" "User: '$user' already \e[33mexists\e[0m. - Skipping"
            continue
        fi
		# Create the user
		sudo useradd -m "$user"
        # Controleer of de gebruiker is toegevoegd
		if id "$user" &>/dev/null; then
		    print_and_log "$log_file" "User: '$user' \e[32mcreated. - Done\e[0m"
            continue
        fi
        # Schrijft bericht van het falen
        print_and_log "$log_file" "\e[31mUser: '$user' was not created. - Fail\e[0m"
	done
}


# Veranderd de passwoorden van gebruikers.
# Print en logt berichten naar een log bestand.
#
# arg1: password; Het nieuwe passwoord.
# arg2: log_file; Een pad naar een bestand om naar te loggen.
# arg[*]: users; De gebruikers voor wie de passwoorden veranderd moeten worden.
change_passwords() {
	local password="$1"
	shift
	local log_file="$1"
	shift
	local users=("$@")

	for user in "${users[@]}"; do
		# Controleer of de gebruiker bestaat
		if ! id "$user" &>/dev/null; then
			print_and_log "$log_file" "\e[33mUser: '$user' does not exist. - Skipping\e[0m"²I
			continue
		fi

		# Zet het passwoord zonder confirmatie
		# Twee keer arg passwoord gezien het passwoord twee keer ingevoerd moet worden.
		echo -e "$password\n$password" | sudo passwd "$user"
		print_and_log "$log_file" "\e[32mPassword set for User: '$user'. - Done\e[0m"
	done
}


# Verander de shell voor een lijst van gebruikers.
# Controleert of er iets veranderd moet worden.
# Print en logt berichten en logs
#
# arg1: new_shell; De nieuwe default shell voor de gebruiker. (bv: bin/bash)
# arg2: log_file; Een pad naar een bestand om naar te loggen.
# arg[*]: users; Een lijst van gebruikers voor wie de shell veranderd moet worden.
#
# Voorbeeld:
# change_shell "/bin/bash" "log.txt" "user1" "user2"
change_shell() {
	local new_shell="$1"
	shift
	local log_file="$1"
	shift
	local users=("$@")
	local current_shell

	# Start bericht
	print_and_log "$log_file" "Changing default shell to $new_shell for user(s): ${users[*]}"

	for user in "${users[@]}"
	do
		# Controleer of de gebruiker bestaat
		if ! id "$user" &>/dev/null; then
			print_and_log "$log_file" "\e[33mUser: $user does not exist. Skipping..\e[0m"
			continue
		fi

		# Verkrijg enkel de shell die door de user gebruikt wordt.
		current_shell=$(getent passwd "$user" | cut -d: -f7)
		# Controleer of de huidige shell anders is dan de nieuwe shell
		if [ "$current_shell" == "$new_shell"  ]; then
			print_and_log "$log_file" "\e[32m$new_shell is already the default shell for user: $user. Skipping..\e[0m"
		else
			# Verander de default shell
			sudo chsh -s "$new_shell" "$user"
			current_shell=$(getent passwd "$user" | cut -d: -f7)
			if [ "$current_shell" == "$new_shell" ]; then
				print_and_log "$log_file" "\e[32mChanged shell from $current_shell to $new_shell for user: $user\e[0m"
				continue
			fi
			# Indien het mislukt, schrijf een error.
			print_and_log "$log_file" "\e[31mCould not change $current_shell to $new_shell for user: $user\e[0m"
		fi
	done
}
