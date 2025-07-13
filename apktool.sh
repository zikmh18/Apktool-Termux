#!/bin/bash

export apktool_version='2.9.2'
export apktool_update='2.12.0'

# colors
reset="\033[00m"
r="\033[1;31m"
g="\033[1;32m"
y="\033[1;33m"
b="\033[1;34m"
p="\033[1;35m"
c="\033[1;36m"
w="\033[1;37m"
usage_banner(){
printf "
${g}  ⠀⠀⠀⠀ ⢀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀
${g}⠀⠀ ⠀ ⠀⠀ ⠙⢷⣤⣤⣴⣶⣶⣦⣤⣤⡾⠋⠀⠀
${g}⠀⠀  ⠀⠀⠀ ⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀
${g}⠀ ⠀⠀ ⠀ ⣼⣿⣿⣉⣹⣿⣿⣿⣿⣏⣉⣿⣿⣧⠀  ${reset}{${y}\033[4mby:zikmh18${reset}}
${g} ⠀⠀⠀  ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇
${g} _____     _ ${c}  _____         _
${g}|  _  |___| |_${c}|_   _|___ ___| |
${g}|     | . | '_|${c} | | | . | . | |
${g}|__|__|  _|_,_|${c} |_| |___|___|_|
${g}      |_|
\n"
}

version(){
printf '\033[1;37mTermux-Apktool version "0.1-beta"\n'
printf "${w}https://github.com/zikmh18/Apktool-Termux\n"
}

function load(){
 printf "."; sleep 0.12
 printf "."; sleep 0.12
 printf "."; sleep 0.12
 printf "."; sleep 0.12
}


update(){
  printf "${reset}[${b}info${reset}] Processing update ${r}${apktool_version} ${reset}to ${g}${apktool_update}\n"
  printf "${reset}[${b}info${reset}] Downloading file apktool_${apktool_update}.jar\n"
  sh -c 'wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_$apktool_update.jar -O $PREFIX/bin/apktool.jar' > /dev/null 2>&1
  chmod +r $PREFIX/bin/apktool.jar
  printf "${reset}[${y}check${reset}] Downloading file apktool ";load
  sh -c 'wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O $PREFIX/bin/apktool' > /dev/null 2>&1
  chmod +x $PREFIX/bin/apktool
  which apktool > /dev/null 2>&1
  if [ "$?" -eq "0" ]; then
      printf " ${g}Ok\n"
  else
      printf " ${r}Error ${reset}(failed to download please check your internet)\n"
  exit 0
  fi
}


install(){
printf "${reset}[${b}info${reset}] Processing installing apktool ${apktool_version}\n"
printf "${reset}[${b}info${reset}] Downloading file apktool_${apktool_version}\n"
sh -c 'wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_$apktool_version.jar -O $PREFIX/bin/apktool.jar' > /dev/null 2>&1
chmod +r $PREFIX/bin/apktool.jar
printf "${reset}[${y}check${reset}] Downloading file apktool ";load
sh -c 'wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O $PREFIX/bin/apktool' > /dev/null 2>&1
chmod +x $PREFIX/bin/apktool
which apktool > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
printf " ${g}Ok\n"
else
printf " ${r}Error ${reset}(failed to download please check your internet)\n\n"
exit 0
fi
}

removed(){
printf "${reset}[${b}info${reset}] Processing removed apktool\n"
rm -rf $HOME/../usr/bin/apktool.jar
rm -rf $HOME/../usr/bin/apktool
sleep 0.27
printf "${reset}[${y}check${reset}] Checking apktool "; load
which apktool > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
printf " ${r}Error ${reset}(failed to removed)\n"
exit 0
else
printf " ${g}Ok ${reset}(Sucessfully to removed)\n\n"
exit 0
fi
}

check(){
which apktool > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
printf "\n${reset}[${y}info${reset}] Apktool installed.\n\n"
else
printf "\n${reset}[${y}info${reset}] Apktool not installed\n\n"
fi
}

usage(){
usage_banner
printf "${reset}Usage: ./apktool.sh [options]

Options:
  -h, --help               Show basic help message and exit
  -i, --install            Installing apktool
  -p, --packages           Installing packages
  -u, --update             Update apktool
  -r, --remove             Uninstall apktool
  -v, --version            Show program's version number and exit
  -c, --check              Checking apktool installed or not installed.
"
}

packages(){
printf "${reset}[${b}info${reset}] Starting installing packages name: openjdk-21\n"
apt install openjdk-21 -y > /dev/null 2>&1
printf "${reset}[${y}check${reset}] Checking installing packages ";load
which java > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
printf " ${g}Ok\n"
else
printf " ${r}Error ${w}(Installing failed please checking your internet)\n\n"
exit 0
fi
}

if [ -z "$*" ]; then
	usage
elif [ $1 == '-i' ] || [ $1 == '--install' ]; then
	usage_banner
	install
elif [ $1 == '-p' ] || [ $1 == '--packages' ]; then
	usage_banner
	packages
elif [ $1 == '-u' ] || [ $1 == '--update' ]; then
	usage_banner
	update
elif [ $1 == '-r' ] || [ $1 == '--remove' ]; then
	usage_banner
	removed
elif [ $1 == '-v' ] || [ $1 == '--version' ]; then
	version
elif [ $1 == '-c' ] || [ $1 == '--check' ]; then
	usage_banner
	check
else
	usage
fi

