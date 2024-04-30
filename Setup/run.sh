#!/bin/bash
#
# Dit script dient voor voor het klaarmaken van een linux server (momenteel Ubuntu) voor het Integration Project.
#
# Functionaliteit van het Script
# Elke stap is optioneel tenzij het afhangt van een andere geannuleerde stap
# - maakt de nodige groepen aan
# - maakt de gebruikers
# - voegt de gebruikers toe aan de juiste groepen
# - veranderd de default shell voor gebruikers
# - maakt de folders en permissions aan voor het project

# Imports
source data/consts.sh
source lib/auth.sh
source lib/log.sh
source lib/groups.sh
source lib/users.sh

# Help function
show_help() {
    echo "Usage: $0 <action> <target>"
    echo "Arguments:"
    echo "  <action>  : The action to perform. Valid actions: set"
    echo "  <target>  : The target for the action. Valid targets: users, passwords, groups, usergroups, shell"
    echo "Example: $0 set users"
    exit 0
}

# Controleer of de help optie is aangeduid
if [ "$#" -eq 1 ] && [ "$1" = "help" ]; then
    show_help
fi

# Controleer de argumenten
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <action> <target>"
    echo "Usage: $0 help"
    exit 1
fi

action="$1"
target="$2"

case "$action" in
    "set")
        case "$target" in
            "users")
                # Maak de gebruikers van elk team.
                create_users "$log_file" "${pm_users[@]}"
                create_users "$log_file" "${kassa_users[@]}"
                create_users "$log_file" "${frontend_users[@]}"
                create_users "$log_file" "${facturatie_users[@]}"
                create_users "$log_file" "${ads_users[@]}"
                # adds en mailing zijn dezelfde groep
                # create_users "$log_file" "${mailing_users[@]}". Zijn dezelde users als adds.
                create_users "$log_file" "${crm_users[@]}"
                create_users "$log_file" "${monitoring_users[@]}"
                create_users "$log_file" "${planning_users[@]}"
                ;;
            "passwords")
                # Verander de passwoorden naar de default.
                change_passwords "$default_password" "$log_file" "${pm_users[@]}"
                change_passwords "$default_password" "$log_file" "${crm_users[@]}"
                change_passwords "$default_password" "$log_file" "${frontend_users[@]}"
                change_passwords "$default_password" "$log_file" "${planning_users[@]}"
                change_passwords "$default_password" "$log_file" "${facturatie_users[@]}"
                change_passwords "$default_password" "$log_file" "${monitoring_users[@]}"
                change_passwords "$default_password" "$log_file" "${mailing_users[@]}"
                change_passwords "$default_password" "$log_file" "${ads_users[@]}"
                change_passwords "$default_password" "$log_file" "${kassa_users[@]}"
                ;;
            "groups")
                # Maak de benodigde groepen
                check_and_create_groups "$log_file" "${project_groups[@]}"
                ;;
            "usergroups")
                # Voeg gebruikers toe aan groep hun groep.
                check_and_add_users_to_group "$pm_group" "$log_file" "${pm_users[@]}"
                check_and_add_users_to_group "$crm_group" "$log_file" "${crm_users[@]}"
                check_and_add_users_to_group "$frontend_group" "$log_file" "${frontend_users[@]}"
                check_and_add_users_to_group "$planning_group" "$log_file" "${planning_users[@]}"
                check_and_add_users_to_group "$facturatie_group" "$log_file" "${facturatie_users[@]}"
                check_and_add_users_to_group "$monitoring_group" "$log_file" "${monitoring_users[@]}"
                check_and_add_users_to_group "$mailing_group" "$log_file" "${mailing_users[@]}"
                check_and_add_users_to_group "$ads_group" "$log_file" "${ads_users[@]}"
                check_and_add_users_to_group "$kassa_group" "$log_file" "${kassa_users[@]}"
                # Add users to their general group
		for group in "${general_groups[@]}"; do
                	check_and_add_users_to_group "$group" "$log_file" "${pm_users[@]}"
                	check_and_add_users_to_group "$group" "$log_file" "${crm_users[@]}"
                	check_and_add_users_to_group "$group" "$log_file" "${frontend_users[@]}"
                	check_and_add_users_to_group "$group" "$log_file" "${planning_users[@]}"
                	check_and_add_users_to_group "$group" "$log_file" "${facturatie_users[@]}"
                	check_and_add_users_to_group "$group" "$log_file" "${monitoring_users[@]}"
                	check_and_add_users_to_group "$group" "$log_file" "${mailing_users[@]}"
                	check_and_add_users_to_group "$group" "$log_file" "${ads_users[@]}"
                	check_and_add_users_to_group "$group" "$log_file" "${kassa_users[@]}"
		done
                ;;
            "shell")
                 # Verander de huidige default shell naar de gedefinieerde default shell.
                 change_shell "$default_shell" "$log_file" "${pm_users[@]}"
                 change_shell "$default_shell" "$log_file" "${crm_users[@]}"
                 change_shell "$default_shell" "$log_file" "${frontend_users[@]}"
                 change_shell "$default_shell" "$log_file" "${planning_users[@]}"
                 change_shell "$default_shell" "$log_file" "${facturatie_users[@]}"
                 change_shell "$default_shell" "$log_file" "${monitoring_users[@]}"
                 change_shell "$default_shell" "$log_file" "${mailing_users[@]}"
                 change_shell "$default_shell" "$log_file" "${ads_users[@]}"
                 change_shell "$default_shell" "$log_file" "${kassa_users[@]}"
                 ;;
            *)
                echo -e "\e[33Invalid action: '$action'\e[0m"
                exit 1
                ;;
            esac
        ;;
    *)
        echo -e "\e[33Invalid action: '$action'\e[0m"
        exit 1
        ;;
esac
