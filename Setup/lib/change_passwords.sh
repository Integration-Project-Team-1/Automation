# Neemt een lijst van users als argument en zet het passwoord (hardcoded en plaintext insecure)
change_passwords() {
	local users=("$@")  
	local password="student1"
	for user in "${users[@]}"; do
		# Zet het passwoord zonder confirmatie
		# Twee keer arg passwoord gezien het passwoord twee keer ingevoerd moet worden
		echo -e "$password\n$password" | sudo passwd "$user"
		echo -e "Password set for '$user'."
	done
}
