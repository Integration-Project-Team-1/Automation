# Verander default shell
# Huidige shell: getent passwd <username> | cut -d: -f7
change_shell() {
	local users=("$@")
	local default_shell="/bin/bash"
	for user in "${users[@]}"
	do
		current_shell=$(getent passwd "$user" | cut -d: -f7)
		if [ "$current_shell" = "/bin/sh" ]; then
			sudo chsh -s "$default_shell" "$user"
			echo -e "Changed default shell for user '$user' to '$default_shell'"
		else
			echo -e "Default shell for user '$user' not /bin/sh, no changes were made."
		fi
	done
}
