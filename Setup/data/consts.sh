#!/bin/bash
#
# Dit bestand definieert groepen en gebruikers en functies om deze af te drukken.

declare log_file="../log.txt"
declare default_shell="/bin/bash"
declare default_password="student1"

# Declaratie van de groepen voor elke service
declare pm_group="pm_groep"
declare crm_group="crm_groep"
declare frontend_group="frontend_groep"
declare planning_group="planning_groep"
declare facturatie_group="facturatie_groep"
declare kassa_group="kassa_groep"
declare monitoring_group="monitoring_groep"
declare mailing_group="mailing_groep"
declare ads_group="ads_groep"

declare -a general_groups=("docker" "student")

# Lijsten met gebruikers per groep
declare -a pm_users=("thuy" "killian")
declare -a crm_users=("ismael" "soufiane" "soufian" "hamza")
declare -a frontend_users=("kristian" "amina" "nour" "nawfel")
declare -a facturatie_users=("carl" "batuhan" "caelan" "mouise")
declare -a ads_users=("bryan" "w_lucas" "koen" "dries")
declare -a mailing_users=("bryan" "w_lucas" "koen" "dries")
declare -a kassa_users=("luca" "abdelillah" "yasmine" "jurgen")
declare -a monitoring_users=("bryana" "dk_lucas" "jarno")
declare -a planning_users=("simon" "rand" "mohamed")

# Combinatie van alle groepen in één array
declare -a project_groups=(
	"$pm_group"
	"$crm_group"
	"$frontend_group"
	"$planning_group"
	"$facturatie_group"
	"$kassa_group"
	"$monitoring_group"
	"$mailing_group"
	"$ads_group"
)

# Combinatie van alle gebruikers in één lijst.
declare -a project_users=(
	"${pm_users[@]}"
	"${crm_users[@]}"
	"${frontend_users[@]}"
	"${facturatie_users[@]}"
	"${ads_users[@]}"
	"${mailing_users[@]}"
	"${kassa_users[@]}"
	"${monitoring_users[@]}"
	"${planning_users[@]}"
)
