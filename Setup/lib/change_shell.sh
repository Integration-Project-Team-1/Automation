#!/bin/bash
#
# Functies om de shell in te stellen.
# Commando om de huidige shell terug te vinden: $ getent passwd <username> | cut -d: -f7

source log.sh

# Verander de shell voor een lijst van gebruikers.
# Controleert of er iets veranderd moet worden en print de stappen.
# Geeft een log terug.
#
# param1: nieuwe shell bv bin/bash
# param[n]: een lijst van users voor wie de shell veranderd moet worden
# output: berichten met de stappen
# returns: het bericht voor de logs
change_shell() {
	local new_shell="$1"
	shift
	local users=("$@")
	local msg_no_change="$new_shell is already the default shell for user: $user. Skipping.."
	local msg_changed="\e[32mChanged default shell for user '$user' to '$default_shell'\e[0m"

	for user in "${users[@]}"
	do
		# Verkrijg enkel de shell die door de user gebruikt wordt.
		current_shell=$(getent passwd "$user" | cut -d: -f7)
		# Controleer of de huidige shell anders is dan de nieuwe shell
		if [ "$current_shell" == "$new_shell"  ]; then
			echo -e "$msg_no_change"
			write_log "$msg_no_change"
		else
			# Verander de default shell
			sudo chsh -s "$new_shell" "$user"
			echo -e "$msg_changed"
			write_log "$msg_changed"
		fi
	done
}

getent passwd fuser | cut -d: -f7
change_shell /usr/bin/zsh
