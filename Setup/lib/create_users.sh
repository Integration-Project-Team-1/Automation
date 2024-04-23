# Creert users
# arg is een lijst van users
create_users() {
	local users=("$@")
	for username in "${users[@]}"; do
		# Check if users exists
		if id "$username" &>/dev/null; then
			echo -e "User '$username' already \e[33mexists\e[0m. skipping..."
		else
			# Create the user
			sudo useradd -m "$username"
			echo -e "User '$username' \e[32mcreated\e[0m."
		fi
	done
}
