#!/bin/bash

log_file="/Users/$USER/.logs.log"
USER=`who -m | awk '{print $1;}'`
HOME="/Users/$USER"
musilaj=1
conf_f="$HOME/.murmur.conf"
bash_login=~/.bash_login
bash_profile=~/.bash_profile
DEV=1
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

i_app

b="|                                      |              murmur_1.0.1             |"

stat "waiting select..." "light_blue" ""

while true; do
  clear
  top_banner "$msg" $color $style
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
    'v') i_valgrind;;
    '7') runner "gnirehtet_installer" ;;
    'x') runner "dynamic_goinfre" ;;
    '6') i_lfs ;;
    'w') runner "web_explorer" ;;
    '5') i_utils ;;
    '0') linex; echo "Çıkılıyor..."; break;;
    "q") linex;clear;echo "Çıkılmak murmurbox.";break;;
    *)
      # linex

      clear
      stat "invalid selection!" "red" "bold"
      # exit 1
      ;;
  esac
done
