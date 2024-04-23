# Eerste arg is de lijst van users voor een group
# Tweede arg is een lijst van extra groups waar ze toe behoren
# De functie voegt iedereen toe aan default groups e.g. sudo?, student
add_users_to_groups() {
	local extra_group=("$1")
	shift
	local user_list=("$@")
	local base_group_list=("sudo" "student")
	
	for user in "${user_list[@]}"; do
		# Add users to the base groups
		for base_group in "${base_group_list[@]}"; do
			if groups "$user" | grep -q "\b$base_group\b"; then
				echo -e "User '$user' is already a member of base group '$base_group'. \e[33mSkipping\e[0m.."
			else
				sudo usermod -aG "$base_group" "$user"
				echo -e "User '$user' \e[32madded\e[0m to group '$base_group'."
			fi
		done
		if groups "$user" | grep -q "$extra_group"; then
			echo -e "User '$user' is already a member of additional group '$extra_group'. \e[33mSkipping\e[0m.."
		else
			sudo usermod -aG "$extra_group" "$user"
			echo -e "User '$user' \e[32madded\e[0m to additional group '$extra_group'."
		fi
	done
}
