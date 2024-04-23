setup_groups() {
	# State variabele om alle 'groups' al dan niet aan te maken
	local create_all_groups=0
	for group in "${all_groups[@]}"; do
	# Check of de 'group' bestaat
	if getent group "$group" >/dev/null; then
		echo -e "Group '$group' \e[33mexists\e[0m."
	else
		if [ $create_all_groups -eq 0 ]; then 
			read -p "Group '$group' does not exist. Do you want to create it? (y/n/a for all): " choice
			case "$choice" in
			y|Y)
				sudo groupadd "$group"
				echo -e "Group '$group' \e[32mcreated\e[0m successfully."
				;;
			a|A)
			create_all_groups=1
			sudo groupadd "$group"
			echo "Group '$group' created successfully."
			;;
			*)
			echo "Skipping group '$group'."
			;;
			esac
		else
				# Maak de nieuwe 'group'
				sudo groupadd "$group"
				echo "Group '$group' created successfully."
		fi
	fi
	done
}
