#!/bin/bash
#
# Dit script dient voor voor het klaarmaken van een linux server (momenteel Ubuntu) voor het Integration Project.
#
# Het script is flexibel en prompt steeds de gebruiker of die specifieke stap uitgevoerd moet worden.
# Met optie "all aA) [Aa][lL][lL]" kan je steeds te stappen uitvoeren voor alle groepen en users om teveel prompts te voorkomen.
#
# Functionaliteit van het Script
# Elke stap is optioneel tenzij het afhangt van een andere geannuleerde stap
# - maakt de nodige groepen aan
# - maakt de users
# - voegt de users toe aan de juiste groepen
# - veranderd de default shell voor users
# - maakt de folders voor het project aan

source ./data/consts.sh
source ./lib/setup_groups.sh
source ./lib/create_users.sh
source ./lib/add_users_to_groups.sh
source ./lib/change_passwords.sh
source ./lib/change_shell.sh

# Maak de benodigde groepen
setup_groups

# Maak de users voor elke groep
create_users "${pm_users[@]}"
create_users "${kassa_users[@]}"
create_users "${frontend_users[@]}"
create_users "${facturatie_users[@]}"
create_users "${ads_users[@]}"
# adds en mailing zijn dezelfde groep
# create_users "${mailing_users[@]}" Dezelde users als adds
create_users "${crm_users[@]}"
create_users "${monitoring_users[@]}"
create_users "${planning_users[@]}"

# Voeg users toe aan groep
add_users_to_groups "${pm_groep[0]}" "${pm_users[@]}"
add_users_to_groups "${crm_groep[0]}" "${crm_users[@]}"
add_users_to_groups "${frontend_groep[0]}" "${frontend_users[@]}"
add_users_to_groups "${planning_groep[0]}" "${planning_users[@]}"
add_users_to_groups "${facturatie_groep[0]}" "${facturatie_users[@]}"
add_users_to_groups "${monitoring_groep[0]}" "${monitoring_users[@]}"
add_users_to_groups "${mailing_groep[0]}" "${mailing_users[@]}"
add_users_to_groups "${ads_groep[0]}" "${ads_users[@]}"
add_users_to_groups "${kassa_groep[0]}" "${kassa_users[@]}"

# Zet het default passwoord voor iedereen
change_passwords "${pm_users[@]}"
change_passwords "${crm_users[@]}"
change_passwords "${frontend_users[@]}"
change_passwords "${planning_users[@]}"
change_passwords "${facturatie_users[@]}"
change_passwords "${monitoring_users[@]}"
change_passwords "${mailing_users[@]}"
change_passwords "${ads_users[@]}"
change_passwords "${kassa_users[@]}"


# Verander de default shell naar /bin/bash voor iedereen die /bin/sh als default heeft.
change_shell "${pm_users[@]}"
change_shell "${crm_users[@]}"
change_shell "${frontend_users[@]}"
change_shell "${planning_users[@]}"
change_shell "${facturatie_users[@]}"
change_shell "${monitoring_users[@]}"
change_shell "${mailing_users[@]}"
change_shell "${ads_users[@]}"
change_shell "${kassa_users[@]}"
