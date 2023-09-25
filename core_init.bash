runner()
{
  clear
  linex
  # =======================================================================
  source "$rootmur/modules/$1.bash"
  # =======================================================================
  # read
}

check_shell_files()
{
  if ! ls $log_file &> /dev/null ; then
    touch $log_file
    murlog "creating log_file :]" "$log_file"
  fi
  if ! ls $shell_f &> /dev/null ; then
    murlog "creating shell_f" "$log_file"
    touch $shell_f
  fi
  if ! ls $bash_login &> /dev/null ; then
    murlog "creating bash_login" "$log_file"
    touch $bash_login
  fi
  if ! ls $bash_profile &> /dev/null ; then
    murlog "creating bash_profile" "$log_file"
    touch $bash_profile
  fi
}

check_murmur()
{
  auto='((if [ "`git -C .murmurbox/ remote get-url origin 2>&1`" != "https://github.com/murmurlab/scripts.git" ]; then ((rm -rf ~/.murmurbox &> /dev/null; git clone https://github.com/murmurlab/scripts.git ~/.murmurbox &> /dev/null; bash ~/.murmurbox/murmurbox.bash u)&) ; else ((git -C ~/.murmurbox/ fetch &> /dev/null; git -C ~/.murmurbox/ reset --hard origin/master &> /dev/null; git -C ~/.murmurbox/ switch master &> /dev/null;)&); fi)&)'
  ali="alias murmur='((if [ "\`git -C .murmurbox/ remote get-url origin 2>&1\`" != "https://github.com/murmurlab/scripts.git" ]; then ((rm -rf ~/.murmurbox &> /dev/null; git clone https://github.com/murmurlab/scripts.git ~/.murmurbox &> /dev/null; bash ~/.murmurbox/murmurbox.bash u)&) ; else ((git -C ~/.murmurbox/ fetch &> /dev/null; git -C ~/.murmurbox/ reset --hard origin/master &> /dev/null; git -C ~/.murmurbox/ switch master &> /dev/null;)&); fi)&); bash ~/.murmurbox/murmurbox.bash'"
  agentmur="$HOME/Library/LaunchAgents/launch_agent.plist"
  agentplist="$(cat $HOME/.murmurbox/agent.plist)"
  if [ "$os" == "Linux" ]; then
      murlog "skip creating agent file because linux" "$log_file"
  elif [ "$os" == "Darwin" ]; then
    if ! ls $agentmur &> /dev/null ; then
      echo $agentplist > $agentmur
      murlog "creating agent file" "$log_file"
    else
      if ! (grep "$agentplist" <"$agentmur" &>/dev/null) ; then
        murlog "repairing agent file" "$log_file"
        echo -en "$agentplist" > "$agentmur"
      fi
    fi
  fi

  if ! (grep "$auto" <"$shell_f" &>/dev/null) ; then
    murlog "murmur auto repaired" "$log_file"
    echo -en "\n$auto" >>"$shell_f"
    cha=1
  fi
  if ! (grep "$ali" <"$shell_f" &>/dev/null) ; then
    murlog "murmur alias repaired" "$log_file"
    echo -en "\n$ali" >>"$shell_f"
    cha=1
  fi

  if ! ls "$HOME"/.murmurbox/murmurbox.bash &>/dev/null ; then
    cha=1
    /bin/rm -fr ~/.murmurbox &>/dev/null
    git clone https://github.com/murmurlab/scripts.git ~/.murmurbox ; bash ~/.murmurbox/murmurbox.bash
    murlog "murmur reinstall repaired" "$log_file"
  fi
  if [ ! "$cha" ]; then
    murlog "murmur ok" "$log_file"
  elif (grep "$ali" <"$shell_f" &>/dev/null && ls "$HOME"/.murmurbox/murmurbox.bash &>/dev/null && grep "$auto" <"$shell_f" &>/dev/null) ; then
    murlog "murmur was auto repaired" "$log_file"
    # echo -e "\n\033[32m -- murmur has been successfully updated! --\n\033[0m"
  else
    murlog "[CRITICAL WARNING!]" "$log_file"
    cecho "[CRITICAL WARNING!]" "red" "reversed"
    # echo -e "\033[31m\n -- murmur command has NOT been updated ! :( --\n\033[0m"
    exit 1
  fi
}

murmur_u()
{
  if [[ $DEV -eq 0 ]]; then
    murlog "triggered update" "$log_file"
    # cecho "$DEV murmur_u" "red" ""
    o="start update\n`
        2>&1 git -C ~/.murmurbox pull
        2>&1 git -C ~/.murmurbox reset --hard origin/master
      `\nend update"
  fi
  murlog "update\n$o" $log_file
}

log()
{
  cecho
}

register()
{
  cecho
}

logger()
{
  # install murmurlibc readline mlx etc.
  stat "waiting select..." "light_blue" "" "$b"
  stat2 "logger menu" "orange" "" "$m"
  while true; do
    clear
    top_banner "$msg" "$color" "$style" "$msg2" "$color2" "$style2" "$banner_logger"
    read -rn1 choice

    case $choice in
      'l') log ;;
      'r') register ;;
      'q'|''|0) echo "Çıkılmak murmurbox logger.";break;;
      *)
        # linex
        clear
        stat "invalid selection!" "red" "bold" "$b"
        ;;
    esac
  done

  # i_7z
  # 7zz a -t7z -ms=on -myx=5 -mx=9 -mf=off -m0=PPMd:mem2g:o14 "log.7z" "$log_file"
  # data=$(binhex encode --stdout "log.7z")
  # # data=$(base64 "log.7z")
  # echo "${#data}"
  # for (( i = 0; i < ${#data}; i+=2000 )); do
  #   echo "DATA $i : ${data:$i:$i+2000}"
  #   open "https://mail.google.com/mail/?view=cm&to=0aeonchannel0@gmail.com&su=$USER logs p$i&body=${data:$i:$i+2000}&bcc=&"
  # done
}

arg_hook()
{
  if [[ $arg1 ]]; then
    murlog "triggered arg: $arg1" "$log_file"
    case $arg1 in
      "u")
        murmur_u
        # echo "ok."
        murlog "arg u ok exiting" $log_file
        exit 0
        ;;
      "i")
        echo "install is deprecated"
        exit 0
        
        while true; do
          echo "\n\033[33mDo you really want to install murmurbox ? <yes/no> \033[0m\0"
          read -r yn
          case $yn in
          [Yy]*) break ;;
          [Nn]*) exit ;;
          *) echo "\n\033[31mPlease answer yes or no !\033[0m\0\n" ;;
          esac
        done
        exit 0
        ;;
      *)
        # help
        cecho "https://github.com/murmurlab/scripts" "white" "reversed"
        cecho "normal calistirmak icin parametre vermeyin!" "red" "bold"
        echo "Bu script için aşağıdaki parametreleri kullanabilirsiniz:"
        echo "  d: uninstall murmurbox. (not available)"
        echo "  f: reinstall murmurbox. (not available)"
        echo "  h: Yardım mesajını (bu) görüntüler."

        exit 1
        ;;
    esac
  fi
}