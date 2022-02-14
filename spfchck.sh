#!/usr/bin/env bash
#-Metadata----------------------------------------------------#
#  Filename: SPFCHCK (v1.0.0)            (Update: 2021-11-04) #
#-Info--------------------------------------------------------#
#  SPF Checker Automation Dig                                 #
#-Author(s)---------------------------------------------------#
#  Blay Raes ~ @ninebrainer                                   #
#-------------------------------------------------------------#





### Variable Name and Version

APPNAME="SPFCHCK"
VERSION="1.0.0#dev"





goBanner(){
echo -e "\n"
echo -e ${SBLUE}"           / _|   | |        | |      ${SPURPLE}           :::::::  ";
echo -e ${SBLUE}" ___ _ __ | |_ ___| |__   ___| | __   ${SPURPLE}          -%%%%%%%-  ";
echo -e ${SBLUE}"/ __| '_ \|  _/ __| '_ \ / __| |/ /   ${SPURPLE}        ###%%%%%%%###.";
echo -e ${SBLUE}"\__ \ |_) | || (__| | | | (__|   <    ${SPURPLE}       .%%*==%%%==*%%.";
echo -e ${SBLUE}"|___/ .__/|_| \___|_| |_|\___|_|\_\   ${SPURPLE}       .%%*-=%%%=-*%%.";
echo -e ${SBLUE}"    | |                                ${SPURPLE}      .##%%%%%%%%%##.";
echo -e ${SBLUE}"    |_|                                ${SPURPLE}        =#-+*:**-#= ";
echo -e ${SBLUE}"                                       ${SPURPLE}       =# -#   #- #=   ";
echo -e ${SBLUE}"                                        ${SPURPLE}     =-=:*=   =*:=-=";
echo -e ${RED}"spfchck ${RESET}* Simple Bash SPF record checker${RESET}${SPURPLE}     .:-.#-   -#.-:.     ";
echo -e ${RESET}     " ~ https://github.com/ninebrainer/SPF_CHECK    ${SPURPLE}=-+. .+-=${RESET}"
echo 
echo 
}


# ✔
# # ❌

#### Colors Output

RESET="\033[0m"			# Normal Colour
RED="\033[0;31m" 		# Error / Issues
GREEN="\033[0;32m"		# Successful       
BOLD="\033[01;01m"    	# Highlight
WHITE="\033[1;37m"		# BOLD
YELLOW="\033[1;33m"		# Warning
PADDING="  "
DPADDING="\t\t"


#### Other Colors / Status Code

LGRAY="\033[0;37m"		# Light Gray
LRED="\033[1;31m"		# Light Red
LGREEN="\033[1;32m"		# Light GREEN
LBLUE="\033[1;34m"		# Light Blue
LPURPLE="\033[1;35m"	# Light Purple
LCYAN="\033[1;36m"		# Light Cyan
SORANGE="\033[0;33m"	# Standar Orange
SBLUE="\033[0;34m"		# Standar Blue
SPURPLE="\033[0;35m"	# Standar Purple      
SCYAN="\033[0;36m"		# Standar Cyan
DGRAY="\033[1;30m"		# Dark Gray
BLACK="\e[0;30m"		# BLACK 


goBanner ## Called Banner DMARCHECK

help () {
	echo "Accepted parameters:"
	echo "Use -d along with a domain name, example sh spfchck.sh -d domain.com"
	echo "Null string will be detected and ignored"
	echo "Use -f along with a file containing domain names, example sh spfchck.sh -f domains.txt"
	echo "Note that the path provided for the file must be a valid one"
}

check_url () {
	domain=$1

	retval=0
	output=$(dig "$domain" txt)
	case "$output" in
		*-all*)
			echo -e "$domain is ${GREEN}NOT vulnerable ✔${RESET} "
		;;
		*~all*)
			echo -e "$domain ${YELLOW}can be vulnerable ❌${RESET}  (email will be sent to spam)"
		;;
		*)
			echo -e "$domain is ${RED}vulnerable ❌${RESET} (No SPF record found)"
			retval=1
		;;
	esac
	return $retval
}

check_file () {

		input=$1
		
		COUNTER=0
		VULNERABLES=0
		while IFS= read -r line
		do
			COUNTER=$((COUNTER=COUNTER+1))
			check_url $line
			VULNERABLES=$((VULNERABLES=VULNERABLES+$?))
		done < $input
		echo -e "\n$VULNERABLES out of $COUNTER domains are ${RED}vulnerable ${RESET}"

}

main () {

	while getopts d:f: flag
	do
		case "${flag}" in
			f) file=${OPTARG};;
			d) domain=${OPTARG};;
		esac
	done

	if [ -n "$domain" ]; then
		check_url $domain
	elif [ -f "$file" ]; then
		check_file $file
	else
		help
	fi

}


if [ $# != 2  ];then
	echo " "
        echo -e 	${RED}"❌" ${RESET} "Wrong execution"
	help
	exit 0
fi

main $@
