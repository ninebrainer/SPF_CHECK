#!/usr/bin/env bash
#-Metadata----------------------------------------------------#
#  Filename: Mangekyo (v1.0.0)           (Update: 2022-02-06) #
#-Info--------------------------------------------------------#
#  Subdomain Enumeration & Analysis.                          #
#-Author(s)---------------------------------------------------#
#  Blay Raes ~ @ninebrainer                                   #
#-------------------------------------------------------------#

main () {

	while getopts d:m: flag
	do
		case "${flag}" in
			f) mode=${OPTARG};;
			d) DOMAIN=${OPTARG};;
		esac
	done

	if [ -n "$DOMAIN" ]; then
		goBanner
		scan_domain 
	
	else
		goBanner
		echo -e "\n ${RED}[❌ERROR❌]${RESET} You need to specify the target domain.${RED}[❌ERROR❌]${RESET}"
        	echo -e "\nUsage: \t$0 <DOMAIN>"
        	echo -e "Example: ./mangekyo.sh -d example.com -m [large/medium/small] -x [OOS domains] ${LGREEN} \u2714 ${RESET}"
        	exit 1
	fi

}


### Variable Name and Version

APPNAME="mangekyo.sh"
VERSION="1.0.0#dev"




goBanner(){
echo -e ${SPURPLE}"               ${LPURPLE}            ${LPURPLE}                       ${RED}*${BLACK}@${RED}, ";
echo -e ${SPURPLE}" _____ ___ ___ ${LPURPLE}___ ___| |_${LPURPLE}_ _ ___            ${RED}@&%%%${BLACK}@@${RED}%%%&&@";
echo -e ${SPURPLE}"|     | .'|   |${LPURPLE} . | -_| '_${LPURPLE}| | | . |        ${RED}@&%%%%${BLACK}@@@${RED}%%%%%%&@";
echo -e ${SPURPLE}"|_|_|_|__,|_|_|${LPURPLE}_  |___|_,_${LPURPLE}|_  |___|       ${RED}&%%%%%%${BLACK}@@@@${RED}&%%%%%%@";
echo -e ${SPURPLE}"              ${LPURPLE}|___|       ${LPURPLE}|___|          ${RED}@&%%%%%&${BLACK}@${RED}&&&${BLACK}@@@@${RED}%%%&";
echo -e ${SPURPLE}"  ______________________________          ${RED}&%%%%${BLACK}@@@@@@&%@@@@${RED}%@";
echo -e ${SPURPLE}"           -+-+-+-+-+-                     ${RED}@${BLACK}&&&${RED}%%%%%%%%%%${BLACK}%@${RED}@";
echo -e ${SPURPLE}"                                             ${RED}@&&%%%%%%%&&@";
echo -e ${SPURPLE}"         ~${VERSION}~${RESET}  by ${DGRAY}@ninebrainer ${RESET}";
echo -e "${RED}    Mangekyo ${RESET}- Subdmain Enumeration and Fuzzer ${RESET}";
echo -e      "\t ~http://github.com/ninebrainer/mangekyo"
}

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





#echo ${DOMAIN}
#echo ${CHAOSDOMAIN}
#echo ${DATE}

scan_domain() { 

goBanner ## Called banner mangekyo
echo -e "\n${BOLD}[${RED}!${RESET}${BOLD}]${RESET} This tool is for ${BOLD}educational${RESET} purpose only.   "
echo -e "${BOLD} ${LGREEN} ${RESET}${BOLD} ${RESET} Usage of Mangekyo for ${BOLD}attacking${RESET} targets ${BOLD}without ${RESET}prior mutual consent is ${RED}illegal${RESET}   "
echo -e "${BOLD} ${LGREEN} ${RESET}${BOLD} ${RESET} developers assume no liability and are not responsible for any misuse or damage cause by this program   "
echo -e "\n${BOLD}[${LCYAN}-${RESET}${BOLD}]${RESET} Perfoming ${RED}${BOLD}RECON${RESET} scans  "


# Timestamp
start_date_time=$(date "+%Y-%m-%d %H:%M:%S")

# Timestamp
end_date_time=$(date "+%Y-%m-%d %H:%M:%S")

# DATE for DIRECTORY
DATE=$(date "+%d-%m-%Y")

# Out of Scope Domain -x 

#ℳ

echo -e "\n${BOLD}[${LBLUE}*${RESET}${BOLD}]${RESET} Load target domain: ${LGREEN}${DOMAIN}${RESET}"
echo -e "${BOLD}${PADDING}${PADDING}-${RESET}${BOLD}${RESET} ${LGREEN}Starting${RESET} scanning @ ${start_date_time} " 
echo -e "\n${BOLD}[${LGREEN}+${RESET}${BOLD}]${RESET} Running & Checking source to be used  " 
echo -e "Starting scan for ${DOMAIN} on ${start_date_time}" | notify -silent 
echo -e "---------------------------------------------\n"

echo "${start_time}" > /dev/null 2>&1

if [ ! -d "~/target" ];then
	mkdir ~/targets
fi 
if [ ! -d "~/targets/${DOMAIN}" ];then
    mkdir ~/targets/${DOMAIN}
 fi
if [ ! -d "~/targets/${DOMAIN}/${DATE}" ];then
    mkdir ~/targets/${DOMAIN}/${DATE}
 fi
if [ ! -d "~/targets/${DOMAIN}/${DATE}/subs" ];then
     mkdir ~/targets/${DOMAIN}/${DATE}/subs
 fi

cd ~/targets/${DOMAIN}/${DATE}/subs

}
 


main $@
