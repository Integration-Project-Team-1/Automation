# Declaratie van groepen
declare pm_groep=("pm_groep")
declare crm_groep=("crm_groep")
declare frontend_groep=("frontend_groep")
declare planning_groep=("planning_groep")
declare facturatie_groep=("facturatie_groep")
declare kassa_groep=("kassa_groep")
declare monitoring_groep=("monitoring_groep")
declare mailing_groep=("mailing_groep")
declare ads_groep=("ads_groep")

# Declaratie van lijsten met gebruikers per groep
declare -a pm_users=("thuy" "killian")
declare -a crm_users=("ismael" "soufiane" "soufian" "hamza")
declare -a frontend_users=("kristian" "amina" "nour" "nawfel")
declare -a facturatie_users=("carl" "batuhan" "caelan" "mouise")
declare -a ads_users=("bryan" "w_lucas" "koen" "dries")
declare -a mailing_users=("bryan" "w_lucas" "koen" "dries")
declare -a kassa_users=("luca" "abdellilah" "yasmine" "jurgen")
declare -a monitoring_users=("bryana" "dk_lucas" "jarno")
declare -a planning_users=("simon" "rand" "mohamed")

# Combinatie van alle groepen in één array
declare -a all_groups=(
"${pm_groep[@]}"
"${crm_groep[@]}"
"${frontend_groep[@]}"
"${planning_groep[@]}"
"${facturatie_groep[@]}"
"${kassa_groep[@]}"
"${monitoring_groep[@]}"
"${mailing_groep[@]}"
"${ads_groep[@]}"
)

# Combinatie van alle gebruikers in één lijst
declare -a all_users=(
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

# Afdrukken van alle groepen
print_all_groups() {
	echo "Alle groepen: ${all_groups[@]}"
}

# Afdrukken van alle gebruikers
print_all_users() {
	echo "Alle gebruikers: ${all_users[@]}"
}

