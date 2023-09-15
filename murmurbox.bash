#!/bin/bash

ver="1.0.3_e"
os=$(uname -s)
USER=`who -m | awk '{print $1;}'`
if [ "$os" == "Linux" ]; then
  if [ "$USER" == "root" ]; then
    HOME="/root"
  else
    HOME="/home/$USER"
  fi
elif [ "$os" == "Darwin" ]; then
  HOME="/Users/$USER"
else
    # Diğer işletim sistemleri için destek yok
    echo "Bu işletim sistemi desteklenmiyor."
fi
log_file="$HOME/.logs.log"
musilaj=0
conf_f="$HOME/.murmur.conf"
bash_login=~/.bash_login
bash_profile=~/.bash_profile
DEV=0
log_file="/Users/$USER/.logs.log"
rootmur="$HOME"/.murmurbox

shell_path=$(ps -o command -p $$ | awk '(NR==2) {print $1}')
shell=$(basename $shell_path)
shell_f="${HOME}/.${shell}rc"

# =============================================================================
shell_f=$bash_profile # ? delete after
# =============================================================================

source "$rootmur/utils.bash"
source "$rootmur/core_init.bash"
source "$rootmur/custom_init.bash"
source "$rootmur/modules/pisi.bash"

check_shell_files

murlog "
--------------------------------------------------------------------------------
Starting murmurBOX!
  version     : $ver
  os          : $os
  shell path  : $shell_path
  shell       : $shell
  shell rc    : $shell_f
  user        : $USER
  home        : $HOME
  musilaj     : $musilaj
  log file    : $log_file
  conf_f      : $conf_f
  bash_login  : $bash_login
  bash_profile: $bash_profile
  dev_mod     : $DEV
" $log_file

if [ $shell != "bash" ]; then
  murlog "murmur triggered on different shell" "$log_file"
  echo "\033[0;31m!!! RUN ON bash !!! bash DEN CALISTIRIN !!!\033[0m"; exit
fi

check_murmur

if [[ $# -eq 0 ]]; then
  murlog "zero arg" "$log_file"
fi

arg1=$1
arg_hook
murmur_u
alias1
customizator

if [[ $musilaj -eq 1 && $DEV -eq 0 ]]; then
  murlog "murmur musilajda" "$log_file"
  cecho "                                murmur musilajda                                " "light_orange" "reversed"
  cecho "müsilaj çalışması vardır lütfen programın bakımının bitmesini bekleyini beklettiğimiz için özür dileriz beklediğiniz için teşekkürler :)" "yellow" "bold"
  exit 1
fi

# i_app

b="|                                      |             murmur_$ver            |"
m="                              \033[0;91mm\033[0;97mu\033[0;91mr\033[0;97mm\033[0;91mu\033[0;97mr\033[0;91mm\033[0;97mu\033[0;91mr\033[0;97mm\033[0;91mu\033[0;97mr\033[0;91mm\033[0;97mu\033[0;91mr\033[0;97mm\033[0;91mu\033[0;97mr\033[0;91m.\033[0m.\033[0;97m.\033[0m           19H15            ?"

msg=""
stat "waiting select..." "light_blue" "" "$b"
stat2 "main menu" "orange" "" "$m"
# stat() sets value to $msg so if not use local in any func, var is set to be global

choice=""

# while true; do
#   if [[ -z "$choice" ]]; then
#     clear
#     echo "$choice"
#     # top_banner "$msg" "$color" "$style" "$msg2" "$color2" "$style2" "$banner_main"
#     sleep 0.1
#   fi
# done &

while true; do
  clear
  top_banner "$msg" "$color" "$style" "$msg2" "$color2" "$style2" "$banner_main"
  read -rn1 choice

  case $choice in
    "ver")
      # cat $shell_f
      i_skicka
      ;;
    'l') logger ;;
    'f') runner "find_fat" ;;
    'c') runner "maktemizlemek" ;;
    'i') runner "mount_and_blade" ;;
    's') runner "sleepwipe_installer" ;;
    'm') runner "matrix" ;;
    '1') runner "brew_installer" ;;
    '2') runner "i_deepl" ;;
    'v') i_valgrind;;
    '7') runner "gnirehtet_installer" ;;
    'x') runner "dynamic_goinfre" ;;
    '6') i_lfs ;;
    'w') runner "web_explorer" ;;
    '5') i_utils 
      stat "waiting select..." "light_blue" "" "$b"
      stat2 "main menu" "orange" "" "$m"
      ;;
    'q'|''|0) linex;clear;echo "Çıkılmak murmurbox.";break;;
    *)
      # linex
      clear
      stat "invalid selection!" "red" "bold" "$b"
      # msg="3132123"
      # exit 1
      ;;
  esac
done