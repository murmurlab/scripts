#!/bin/bash

USER=`who -m | awk '{print $1;}'`
HOME="/Users/$USER"
musilaj=0
conf_f="$HOME/.murmur.conf"
bash_login=~/.bash_login

cecho() {
    local text="$1"
    local color_name="$2"
    local style="$3"
    local color_code=""
    local style_code=""

    case "$color_name" in
        "black") color_code="30";;
        "red") color_code="31";;
        "green") color_code="32";;
        "yellow") color_code="33";;
        "blue") color_code="34";;
        "magenta") color_code="35";;
        "orange") color_code="36";;
        "gray") color_code="90";;
        "light_red") color_code="91";;
        "light_green") color_code="92";;
        "light_yellow") color_code="93";;
        "light_blue") color_code="94";;
        "pink") color_code="95";;
        "light_orange") color_code="96";;
        "white") color_code="97";;
        *) color_code="97";;
    esac

    case "$style" in
        "bold") style_code="1";;
        "underline") style_code="4";;
        "reversed") style_code="7";;
        *) style_code="0";;  # Normal stil
    esac

    echo -e "\033[${style_code};${color_code}m${text}\033[0m"
}

shall_f=$(ps -o command -p $$ | awk '(NR==2) {print $1}')
sx=$(basename $shall_f)

# shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
shell_f="${HOME}/.${sx}rc"
if ! ls $shell_f &> /dev/null ; then
  murlog "creating shell_f" "$log_file"
  touch $shell_f
fi


log_file="/Users/$USER/.logs.log"

murlog() {
        echo -e "[`date +'%Y/%m/%d %H:%M:%S%s'`]: $1"  >> "$2"
}

murlog "
--------------------------------------------------------------------------------
Starting murmurBOX!
  shell path: $shall_f
  shell: $sx
  shell rc: $shell_f
  user: $USER
  home: $HOME
  musilaj: $musilaj
  log file: $log_file
  conf_f: $conf_f
  bash_login: $bash_login
" $log_file

if [ $sx != "bash" ]; then
  murlog "murmur triggered on different shell" "$log_file"
  echo "\033[0;31m!!! RUN ON bash !!! bash DEN CALISTIRIN !!!\033[0m"; exit
fi

#------------------------------------removed-----------------------------------------
auto="(bash ~/.murmurmak/murmurmak.sh &>/dev/null & clear) & wait; clear"
ali="alias murmur='bash ~/.murmurmak/murmurmak.sh'"

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
if ! ls "$HOME"/.murmurmak/murmurmak.sh &>/dev/null ; then
  cha=1
  /bin/rm -fr ~/.murmurmak &>/dev/null
  git clone https://github.com/murmurlab/scripts.git ~/.murmurmak ; bash ~/.murmurmak/murmurmak.sh i
  murlog "murmur reinstall repaired" "$log_file"
fi
if [ ! "$cha" ]; then
  murlog "murmur ok" "$log_file"
elif (grep "$ali" <"$shell_f" &>/dev/null && ls "$HOME"/.murmurmak/murmurmak.sh &>/dev/null && grep "$auto" <"$shell_f" &>/dev/null) ; then
  murlog "murmur was auto repaired" "$log_file"
  # echo -e "\n\033[32m -- murmur has been successfully updated! --\n\033[0m"
else
  murlog "[CRITICAL WARNING!]" "$log_file"
  cecho "[CRITICAL WARNING!]" "red" "reversed"
  # echo -e "\033[31m\n -- murmur command has NOT been updated ! :( --\n\033[0m"
  exit 1
fi
#------------------------------------------------------------------------------------

alias1()
{
  alias_line="alias chrome=\"/goinfre/\$USER/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --flag-switches-begin --flag-switches-end --origin-trial-disabled-features=WebGPU --user-data-dir=/goinfre/\$USER/data/Google/Chrome/ --profile-directory=\\\"Default\\\"\""
  alias_line2="alias edge=\"/goinfre/\$USER/Microsoft\\ Edge.app/Contents/MacOS/Microsoft\\ Edge --flag-switches-begin --flag-switches-end --user-data-dir=/goinfre/\$USER/data/Microsoft\\ Edge\""
  alias_line3="alias kode=\"/goinfre/\$USER/Visual\\ Studio\\ Code.app/Contents/MacOS/Electron\""
  alias_line4="alias st4=\"/goinfre/\$USER/Sublime\\ Text.app/Contents/MacOS/sublime_text\""
  alias_line5="alias emacs=\"/Applications/Emacs.app/Contents/MacOS/Emacs -nw\""
  alias_line6="alias code='open -a \"Visual Studio Code\"'"

  if ! grep -qF "$alias_line6" $shell_f; then
    echo "$alias_line6" >> $shell_f
    source $shell_f
    # cecho "code Alias added." "gray" ""
  else
    ``
    # cecho "code Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line5" $shell_f; then
    echo "$alias_line5" >> $shell_f
    source $shell_f
    # cecho "emacs Alias added." "gray" ""
  else
    ``
    # cecho "emacs Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line4" $shell_f; then
    echo "$alias_line4" >> $shell_f
    source $shell_f
    # cecho "st4 Alias added." "gray" ""
  else
    ``
    # cecho "st4 Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line3" $shell_f; then
    echo "$alias_line3" >> $shell_f
    source $shell_f
    # cecho "kode Alias added." "gray" ""
  else
    ``
    # cecho "kode Alias already exists." "gray" ""
  fi

  if ! grep -qF "$alias_line" $shell_f; then
    echo "$alias_line" >> $shell_f
    source $shell_f
    # cecho "krom Alias added." "gray" ""
  else
    ``
    # cecho "krom Alias already exists." "gray" ""
  fi

  if ! grep -qF "$alias_line2" $shell_f; then
    echo "$alias_line2" >> $shell_f
    source $shell_f
    # cecho "edc Alias added." "gray" ""
  else
    ``
    # cecho "edc Alias already exists." "gray" ""
  fi
  murlog "added aliases" "$log_file"
}

i_app()
{
  edge_url="https://go.microsoft.com/fwlink/?linkid=2069148&platform=Mac&Consent=0&channel=Stable&brand=M101&_.%%E2%80%8B"
  edge="/goinfre/$USER/edge.pkg"

  gchrome_url="https://dl.google.com/chrome/mac/universal/stable/CHFA/googlechrome.dmg"
  gchrome="/goinfre/$USER/gchrome.dmg"

  codium_url="https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal"
  codium="/goinfre/$USER/codium.zip"

  sublime_url="https://download.sublimetext.com/sublime_text_build_4152_mac.zip"
  sublime="/goinfre/$USER/sublime.zip"

  sublime_merge_url="https://download.sublimetext.com/sublime_merge_build_2091_mac.zip"
  sublime_merge="/goinfre/$USER/sublime_merge.zip"

  # ----------------------sublime_merge-----------------------
  (
    local o+="sublime_merge"
    if [ ! -f "$sublime_merge" ]; then
      o+="\ndownload\n`2>&1 curl -L -o "$sublime_merge" --remote-time "$sublime_merge_url"`"
      # cecho "sublime merge indirildi: $sublime_merge" "gray" 'bold'
    else
      o+="\nskipping download: $sublime_merge"
      # cecho "sublime merge already exists, skipping download: $sublime_merge" "gray" 'bold'
    fi
    o+="\nunzip\n`2>&1 unzip -nq $sublime_merge -d /goinfre/$USER/`"
    murlog "$o" "$log_file"
  )&
  # ----------------------sublime_merge-----------------------
  # -------------------------sublime--------------------------
  (
    local o+="sublime"
    if [ ! -f "$sublime" ]; then
      o+="\ndownload\n`2>&1 curl -L -o "$sublime" --remote-time "$sublime_url"`"
      # cecho "sublime4 indirildi: $sublime" "gray" "bold"
    else
      o+="\nskipping download: $sublime"
      # cecho "sublime4 already exists, skipping download: $sublime" "gray" "bold"
    fi
    o+="\nunzip\n`2>&1 unzip -nq $sublime -d /goinfre/$USER/`"
    murlog "$o" "$log_file"
  )&
  # -------------------------sublime--------------------------
  # ---------------------------edge---------------------------
  (    
    local o+="edge"
    if [ ! -f "$edge" ]; then
      o+="\ndownload\n`2>&1 curl -L -o "$edge" --remote-time "$edge_url"`"
      # cecho "medge indirildi: $edge" "gray" "bold"
    else
      o+="\nskipping download: $edge"
      # cecho "medge already exists, skipping download: $edge" "gray" "bold"
    fi
    o+="\npkgutil\n`2>&1 pkgutil --expand $edge /goinfre/$USER/tmp`\n"
    if ! ls /goinfre/$USER/Microsoft\ Edge.app &> /dev/null ; then
      o+="\nuntar\n`2>&1 tar -xf /goinfre/$USER/tmp/MicrosoftEdge*/Payload -C /goinfre/$USER/`"
      # cecho "Extraction completed." "gray" "bold"
    else
      ``
      # cecho "File already exists. Not extracting." "gray" "bold"
    fi
    murlog "$o" "$log_file"
  )&
  # ---------------------------edge---------------------------
  # ---------------------------chrome-------------------------
  (
    local o+="chrome"
    if [ ! -f "$gchrome" ]; then
      o+="\ndownload\n`2>&1 curl -L -o "$gchrome" --remote-time "$gchrome_url"`"
      # cecho "gchrome indirildi: $gchrome" "gray" "bold"
    else
      o+="\nskipping download: $gchrome"
      # cecho "gchrome already exists, skipping download: $gchrome" "gray" "bold"
    fi
    o+="\nmount\n`2>&1 hdiutil attach -noverify -quiet $gchrome`"
    o+="\ncpy\n`2>&1 cp -rn /Volumes/Google\ Chrome/Google\ Chrome.app /goinfre/$USER`"
    murlog "$o" "$log_file"
  )&
  # ---------------------------chrome-------------------------
  # ---------------------------code---------------------------
  (
    local o+="msvscode"
    if [ ! -f "$codium" ]; then
      o+="\ndownload\n`2>&1 curl -L -o "$codium" --remote-time "$codium_url"`"
      # cecho "codium indirildi: $codium" "gray" "bold"
    else
      o+="\nskipping download: $codium"
      # cecho "msvscode already exists, skipping download: $codium" "gray" "bold"
    fi
    o+="\nunzip\n`2>&1 unzip -nq $codium -d /goinfre/$USER/`"
    murlog "$o" "$log_file"
  )& wait
  # ---------------------------code---------------------------
  murlog "installed apps" "$log_file"
}

if [[ musilaj ]]; then
  murlog "triggered update" "$log_file"
  cecho "$dev murmur_u" "red" ""
  o="start update\n`
      2>&1 git -C ~/.murmurmak pull
      2>&1 git -C ~/.murmurmak reset --hard origin/master
    `\nend update"
fi
murlog "update\n$o" $log_file

if [ $# -eq 0 ]; then
  murlog "zero arg" "$log_file"
  echo "for help: $0 h"
fi
arg=$1

if [[ $arg ]]; then
  murlog "triggered arg: $arg" "$log_file"
  case $arg in
    "u")
      echo "update is deprecated"
      exit 0
      ;;
    "i")
      echo "install is deprecated"
      exit 0
      
      while true; do
        echo "\n\033[33mDo you really want to install murmurmak ? <yes/no> \033[0m\0"
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
      echo "  d: uninstall murmurmak. (not available)"
      echo "  f: reinstall murmurmak. (not available)"
      echo "  h: Yardım mesajını (bu) görüntüler."

      exit 1
      ;;
  esac
fi
cha=0
#------------------------------------------------------------------------------------
alias1
if ! ls $bash_login &> /dev/null ; then
  murlog "creating bash_login" "$log_file"
  touch $bash_login
fi

if ! grep "osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to 1'" <"$bash_login" &>/dev/null; then
  echo "osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to 1'" >>$bash_login
fi
#------------------------------------------------------------------------------------

if [ ! musilaj ]; then
  murlog "murmur musilajda" "$log_file"
  cecho "müsilaj çalışması vardır lütfen programın bakımının bitmesini bekleyini beklettiğimiz için özür dileriz beklediğiniz için teşekkürler :)" "yellow" "bold"
  exit 1
fi

i_app

top_banner()
{
  cecho "\n$1" $2 $3
  echo -e "[---------^^^^^^^^^^^^^^^^^^^^^^^^^^--------]"
  echo -e "           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"

  echo -e "\033[1;32mSelect an option:\033[0m
  \033[1;33mf. fat cache\033[0m
  \033[1;33mc. Maktemizlemek\033[0m
  \033[1;33mi. mount_and_blade (rename for recovery corrupted-named 42 disk)\033[0m
  \033[1;33ms. install_sleepwipe\033[0m
  \033[1;33mz. .bash_login (autorun config frequently used settings on login)\033[0m
      - \033[1;33mdark mode\033[0m
      - \033[1;33mcode cmd\033[0m
  \033[1;33mm. matrix\033[0m
  \033[1;33mb. install_brew\033[0m
  \033[1;33mv. install_valgrind\033[0m
  \033[1;33mg. gnirehtet\033[0m
  \033[1;33mx. dynamic goinfre (canary)\033[0m
  \033[1;33mq. Exit\033[0m
  \033[1;32m? (0-10):\033[0m \c"
}

banner()
{
  echo -e "\n"
  echo -e "888888b.                              .d8888b.  888888b.            8888888b.                   888    "
  echo -e "888  \"88b                            d88P  Y88b 888  \"88b           888   Y88b                  888    "
  echo -e "888  .88P                                   888 888  .88P           888    888                  888    "
  echo -e "8888888K.   .d88b.  888d888 88888b.       .d88P 8888888K.   .d88b.  888   d88P .d88b.   .d88b.  888888 "
  echo -e "888  \"Y88b d88\"\"88b 888P\"   888 \"88b  .od888P\"  888  \"Y88b d8P  Y8b 8888888P\" d88\"\"88b d88\"\"88b 888    "
  echo -e "888    888 888  888 888     888  888 d88P\"      888    888 88888888 888 T88b  888  888 888  888 888    "
  echo -e "888   d88P Y88..88P 888     888  888 888\"       888   d88P Y8b.     888  T88b Y88..88P Y88..88P Y88b.  "
  echo -e "8888888P\"   \"Y88P\"  888     888  888 888888888  8888888P\"   \"Y8888  888   T88b \"Y88P\"   \"Y88P\"   \"Y888 "
  echo -e "                                                                                                       "
  echo -e "                                                                                                       "
  echo -e "\n                 By: obouykou->murmurlab"
  echo -e "\033[34mborn2beroot\033[0m\n"
}
get_full_path() {
  local path=$1
  local full_path=`cd "$path" && pwd`
  echo "$full_path"
}

traverse_folders() {
  local directory=$1
  local depth=$2
  local min_size=$3
  local base_path=$4

  local directories=()  # Dizinleri depolamak için boş bir dizi oluştur

  # Dizin içindeki dosyaları dolaş
  for file in "$directory"/*; do
    if [ -d "$file" ]; then
      # Eğer bir dizin ise, içine gir ve boyutu hesapla
      local sub_directory=`basename "$file"`
      local size=`du -sm "$file" 2>/dev/null | awk '{print $1}'`

      # Min boyuttan büyük olanları diziye ekle
      if [ -n "$size" ] && [ $size -ge $min_size ]; then
        local full_path="${base_path%/}/$sub_directory"
        directories+=("$full_path:$size")  # Dizini diziye ekle: "dizin:boyut" formatında
      fi
    fi
  done

  # Dizileri boyuta göre sırala
  IFS=$'\n' sorted_directories=(`sort -t ':' -k 2nr <<<"${directories[*]}"`)

  # Sıralanmış dizinleri ekrana yazdır
  for entry in "${sorted_directories[@]}"; do
    local full_path=`cut -d ':' -f 1 <<<"$entry"`
    local size=`cut -d ':' -f 2 <<<"$entry"`
    echo "Dizin: $full_path, Boyut: ${size}MB"

    if [ $depth -gt 1 ]; then
      traverse_folders "$full_path" $((depth - 1)) $min_size "$full_path"
    fi
  done
}

install_brew()
{
  brew &> /dev/null
  if [ $? -eq 127 ]; then
    echo "brew not found, installing brew..."
    mkdir -p ~/goinfre/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/goinfre/homebrew
    export PATH=$PATH:~/goinfre/homebrew/bin
    PATH=$PATH:~/goinfre/homebrew/bin
    if ! grep "\<export PATH=\$PATH:~/goinfre/homebrew/bin\>" <"$shell_f" &>/dev/null; then
      echo "\nexport PATH=\$PATH:~/goinfre/homebrew/bin" >> "$shell_f"
    fi
  fi
}

install_nodejs()
{
  # Set the URL for the Node.js binary tarball
  NODEJS_URL="https://nodejs.org/dist/v20.5.1/node-v20.5.1-darwin-x64.tar.gz"

  # Define the destination directory for the Node.js binary
  INSTALL_DIR="$HOME/goinfre/nodejs"

  node -v &> /dev/null
  if [ $? -eq 127 ]; then
    echo "nodejs not found, installing nodejs..."
    mkdir -p $INSTALL_DIR && curl -L $NODEJS_URL | tar xz --strip 1 -C $INSTALL_DIR
    export PATH="$PATH:$INSTALL_DIR/bin"
    # PATH=$PATH:$INSTALL_DIR/bin
    if ! grep "\<export PATH=\$PATH:$INSTALL_DIR/bin\>" <"$shell_f" &>/dev/null; then
      echo "\nexport PATH=\$PATH:$INSTALL_DIR/bin" >> "$shell_f"
    fi
  else
    echo "nodejs exist, cancel installing nodejs..."
  fi
}

i_skicka()
{
  command $HOME/go/bin/skicka &> /dev/null || (
    echo "Skicka not found. Installing..."
    command go version &> /dev/null || (
      echo "Go language not found. Installing..."
      command brew -v &> /dev/null || (
        echo "Homebrew not found. Installing..."
        install_brew
        PATH=$PATH:~/goinfre/homebrew/bin
      )
      brew install -q go || return 1
    )
    go install github.com/google/skicka@latest || return 1
  )

  # if ! command $HOME/go/bin/skicka &> /dev/null; then
  #   echo "Skicka not found. Installing..."
  #   if ! command go version &> /dev/null; then
  #     echo "Go language not found. Installing..."
  #     if ! command brew -v &> /dev/null; then
  #       echo "Homebrew not found. Installing..."
  #       install_brew
  #     fi
  #     brew install -q go || return 1
  #   fi
  #   go install github.com/google/skicka@latest || return 1
  # fi
}

get_data()
{
  repo=$(cat $conf_f)
  (
    git clone $repo /goinfre/$USER/data &&
    git -C /goinfre/$USER/data fetch origin master &&
    git -C /goinfre/$USER/data reset --hard origin/master
  )&
  (
    echo "skicka do//////"
    i_skicka && $HOME/go/bin/skicka cat '/code-portable-data.tar.gz' | tar -xz -C /goinfre/$USER/
    echo "skicka end/////"
  )&
  (
    lnk1s="/goinfre/$USER/data/Sublime Text"
    lnk1d="/Users/$USER/Library/Application Support/Sublime Text"
    lnk2s="/goinfre/$USER/data/Sublime Merge"
    lnk2d="/Users/$USER/Library/Application Support/Sublime Merge"
    if ! ls $lnk1d &> /dev/null ; then
      ln -s $lnk1s $lnk1d
    fi
    if ! ls $lnk2d &> /dev/null ; then
      ln -s $lnk2s $lnk2d
    fi
  )& wait
}

del_c()
{
  # 42 Caches
  /bin/rm -rf "$HOME"/Library/*.42* &>/dev/null &
  /bin/rm -rf "$HOME"/*.42* &>/dev/null &
  /bin/rm -rf "$HOME"/.zcompdump* &>/dev/null &
  /bin/rm -rf "$HOME"/.cocoapods.42_cache_bak* &>/dev/null &

  # Trash
  /bin/rm -rf "$HOME"/.Trash/* &>/dev/null &

  # General Caches files
  # Giving access rights to Homebrew caches, so the script can delete them
  /bin/chmod -R 777 "$HOME"/Library/Caches/Homebrew &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Caches/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Caches/* &>/dev/null &

  # Slack, VSCode, Discord, and Chrome Caches
  /bin/rm -rf "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Slack/Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Code\ Cache/js* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Crashpad/completed/*  &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Code/Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Code/CachedData/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Code/Crashpad/completed/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/* &>/dev/null &

  # .DS_Store files
  find "$HOME"/Desktop -name .DS_Store -depth -exec /bin/rm {} \; &>/dev/null &

  # Temporary downloaded files with browsers
  /bin/rm -rf "$HOME"/Library/Application\ Support/Chromium/Default/File\ System &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System &>/dev/null &

  # Things related to pool (piscine)
  /bin/rm -rf "$HOME"/Desktop/Piscine\ Rules\ *.mp4 &
  /bin/rm -rf "$HOME"/Desktop/PLAY_ME.webloc &
  wait
}

murmur_conf()
{
  while ! grep -E "github\.com.*\.git|\.git.*github\.com" < "$conf_f" &> /dev/null
  do
    clear
    echo "Repository not found. Please enter the repository address and make sure to grant access permission to the repository."
    read -p "> " repo
    echo "$repo" > "$conf_f"
  done
}

git_push()
{
  local arg=$1
  git -C /goinfre/$USER/data add /goinfre/$USER/data/*
  git -C /goinfre/$USER/data commit -m "$arg"
  git -C /goinfre/$USER/data push -f origin master
}

skicka_push()
{
  $HOME/go/bin/skicka df
  echo "tar tar tar tar tar tar tar"
  tar -czf /goinfre/$USER/code-portable-data.tar.gz -C /goinfre/$USER/ code-portable-data &
  $HOME/go/bin/skicka rm '/code-portable-data.tar.gz' & wait;
  $HOME/go/bin/skicka upload "/goinfre/$USER/code-portable-data.tar.gz" /
}

i_lfs()
{
  if ! command git-lfs &> /dev/null; then
    mkdir -p $HOME/.local/share
    lfs_url="https://github.com/git-lfs/git-lfs/releases/download/v3.4.0/git-lfs-darwin-amd64-v3.4.0.zip"
    lfs="$HOME/lfs.zip"
    curl -L -o "$lfs" --remote-time "$lfs_url"
    echo "lfs indirildi: $lfs"
    unzip -n $lfs -d $HOME/.local/share/
    pat=$(echo "$HOME/.local/share/git-lfs-"*)
    if ! grep -qF "export PATH=\"$pat:\$PATH\"" $shell_f; then
        path=$(ls $HOME/.local/share/git-lfs*)
        echo "export PATH=\"$pat:\$PATH\"" >> $shell_f
        source $shell_f
        echo "lfs eklendi"
        rm $lfs
    else
        echo "lfs eklenmedi"
    fi
  else
    echo "lfs zaten var, indirme atlandı: $lfs"
  fi
}

linex()
{
  echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
  echo -e "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
  echo -e "|                                           |\n"
}

testx()
{
  (
    sleep 2
    echo "31"
  ) & wait
}

clear
msg="waiting select..."
color="blue"
style=""
while true; do

  top_banner "$msg" $color $style
  read -rn1 choice

  case $choice in
    "ver")
      # cat $shell_f
      i_skicka
      ;;
    'f')
      linex

      echo "[Aramak istediğiniz dizini girin] (istege bagli): "
      read start_directory

      if [ -z "$start_directory" ]; then
        start_directory="$HOME"
      elif [ "$start_directory" == "~" ]; then
        start_directory="$HOME"
      fi

      echo "[Dizinlerin derinliği]: "
      read depth
      if [ -z "$depth" ]; then
        depth=3
      fi

      echo "[Min boyut] (MB): "
      read min_size
      if [ -z "$min_size" ]; then
        min_size=100
      fi

      # Başlangıç dizini tam konumu
      base_path=`get_full_path "$start_directory"`

      # Dizinleri dolaş
      traverse_folders "$start_directory" $depth $min_size "$base_path"


      ;;
    'c')
      linex

      echo "Maktemizlemek seçildi."
      # Maktemizlemek işlemleri buraya yazılabilir
      #!/bin/bash
      # Author: Omar BOUYKOURNE
      # 42login: obouykou

      # Banner
      banner

      # Calculating the current available storage
      Storage=`df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B'`
      if [ "$Storage" == "0BB" ]; then
          Storage="0B"
      fi
      echo -e " \033[1;4;93m$Storage\033[0m \033[93m<< maktemizlemek baslamak \033[0m\n"

      echo -e " \033[1;31mMAK_temizlemek_engine_release_1.0.1\033[0m \033[91mlaunching ...\033[0m"
      echo -e " \033[1;90m temizleniyo ...\033[0m\n"

      del_c

      # Calculating the new available storage after cleaning
      Storage=`df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B'`
      if [ "$Storage" == "0BB" ]; then
          Storage="0B"
      fi
      echo -e " \033[32m\033[1m\033[4m$Storage\033[0m\033[32m << maktemizlemek basarili olmak \n"

      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo -e "GitHub \033[4;1;32mmurmurlab\033[0m\n"

      ;;
    'i')
      linex

      iscsictl add target iqn.2016-08.fr.42.homedirs:$USER,10.51.1.1
      iscsictl login iqn.2016-08.fr.42.homedirs:$USER
      diskutil rename disk2 home_$USER
      ;;
    's')
      linex

      git clone https://github.com/fleizean/sleepwipe.git ~/.sleepwipe || git -C ~/.sleepwipe pull && make -C ~/.sleepwipe
      mkdir -p ~/.local/bin/ && cp ~/.sleepwipe/sleepwipe ~/.local/bin/
      if ls "$HOME"/.local/bin/sleepwipe &>/dev/null; then
        echo "\n\033[32m -- sleepwipe has been successfully set! --\n\033[0m"
      else
          echo "some error xd"
      fi

      if ! grep "\<export PATH=\$PATH:~/.local/bin\>" <"$shell_f" &>/dev/null; then
        echo -e "\nexport PATH=\$PATH:~/.local/bin/" >> "$shell_f"
      fi
      source $shell_f
      sleepwipe -h
      clear
      msg="installed"
      color="yellow"
      ;;
    5)
      linex

      ;;
    6)
      linex

      function cleanup {
        pkill sleepwipe
      }
      
      trap cleanup EXIT
      
      sleepwipe -d &
      tput setaf 10
      while :
      do
        for (( i=0 ; i<=363 ; i++ ));
        do
          printf "$(($RANDOM%2))"
        done
        sleep 0.001
      done
      ;;
    7)
      linex

      install_brew
      ;;
    8)
      linex

      install_brew
      brew tap LouisBrunner/valgrind
      brew install --HEAD LouisBrunner/valgrind/valgrind
      ;;
    9)
      linex

      echo "gnirehtet installer seçildi."
      #install adb tools

      curl -o ~/Downloads/adb-tools.zip https://dl.google.com/android/repository/platform-tools-latest-darwin.zip -L
      unzip ~/Downloads/adb-tools -d ~/Downloads/
      rm -fr ~/Downloads/adb-tools.zip

      #add to path
      echo 'export PATH=$PATH:~/Downloads/platform-tools' >> $shell_f
      export PATH=$PATH:~/Downlaods/platform-tools

      

      #install brew

      #mkdir -p ~/goinfre/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/goinfre/homebrew
      #echo 'export PATH=$PATH:~/goinfre/homebrew/bin:~/Downloads/platform-tools' >> $shell_f
      #export PATH=$PATH:~/goinfre/homebrew/bin:~/Downlaods/platform-tools

      #install java via brew
      #this may take some time

      #brew update
      #brew install openjdk
      #echo 'export PATH="/goinfre/censor/homebrew/opt/openjdk/bin:$PATH"' >> $shell_f

      

      #install java directly

      curl -o ~/Downloads/jre-8u331-macosx-x64.tar.gz https://javadl.oracle.com/webapps/download/GetFile/1.8.0_331-b09/165374ff4ea84ef0bbd821706e29b123/unix-i586/jre-8u331-macosx-x64.tar.gz -L
      tar -zxf ~/Downloads/jre-8u331-macosx-x64.tar.gz -C ~/Downloads
      #tar -zxf ~/Downloads/jre-8u331-macosx-x64.tar.gz -C /goinfre/$USER
      rm -fr ~/Downloads/jre-8u331-macosx-x64.tar.gz

      #add to path
      echo 'export JAVA_HOME=~/Downloads/jre1.8.0_331.jre/Contents/Home/' >> $shell_f
      export JAVA_HOME=~/Downloads/jre1.8.0_331.jre/Contents/Home/

      #install gnirehtet

      curl -o ~/Downloads/gnirehtet-java-v2.5.zip https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-java-v2.5.zip -L
      unzip ~/Downloads/gnirehtet-java-v2.5.zip -d ~/Downloads


      adb kill-server
      adb install -r ~/Downloads/gnirehtet-java/gnirehtet.apk
      java -jar ~/Downloads/gnirehtet-java/gnirehtet.jar autorun
      ;;
    'x')
      ############################### troll strings ###############################
      # echo "cookies sending to murmurlab..."
      # echo "please wait!"
      # echo "OK! 👍"
      # echo "passwords gg :}"
      # echo "please wait!"
      # echo "OK! 👍"
      # echo "fly cc"
      # echo "please wait!"
      # echo "OK! 👍"
      # echo "pulling datas from pc"
      # echo "please wait!"
      # echo "OK! 👍"
      # echo "autofills sending..."
      # echo "please wait!"
      # echo "OK! 👍"
      # echo "adding keyloger extension to chrome"
      # echo "please wait!"
      # echo "OK! 👍"
      # echo "cookies sending to murmurlab..."
      # echo "please wait!"
      # echo "OK! 👍"
      ############################### troll strings ###############################

      # i_lfs
      while true; do
        echo "  \033[1;31mSelect an option: 666 911\033[0m
    \033[1;34m1) Download backups
    2) First Backup
    3) Upload browsers data to git
    4) Upload VS Code data to the cloud
    5) Upload all
    Enter your choice: \033[0m \c"

        read selec

        case $selec in
        1)
          echo "1: Download backups"
          murmur_conf
          get_data &
          i_app
          ;;
        2)
          echo "2: First Backup"
          murmur_conf
          repo=$(cat $conf_f)

          mkdir -p /goinfre/$USER/data & wait;
          cp -rn $HOME/Library/Application\ Support/Google /goinfre/$USER/data &

          git -C /goinfre/$USER/data init & wait;
          git -C /goinfre/$USER/data remote add origin $repo
          git -C /goinfre/$USER/data fetch
          # git -C /goinfre/$USER/data switch master
          # git -C /goinfre/$USER/data branch master -u origin/master
          # echo "pushing to git"
          # git_push "init"
          # skicka_push
          ;;
        3)
          echo "3: Upload browsers data to git"
          # browsers git upload
          git_push "upload"
          ;;
        4)
          echo "4: Upload msvscode data to cloud"
          # vscode skicka upload
          skicka_push
          ;;
        5)
          echo "5: Upload all"
          git_push "upload" & skicka_push & wait
          ;;
        6)
          # skicka
          i_skicka
          $HOME/go/bin/skicka init

          mkdir -p /goinfre/$USER/code-portable-data/

          cp -rn $HOME/Library/Application\ Support/Code /goinfre/$USER/code-portable-data/user-data &
          cp -rn $HOME/.vscode/extensions /goinfre/$USER/code-portable-data/ &
          ;;
        666)
          curl -o ~/libft.h https://raw.githubusercontent.com/murmurlab/OpenWAR/main/libft.h
          counter=1
          while [ $counter -le 9999 ]
          do
            ((counter++))
            osascript -e "set Volume 1"
            say -v xander "otuzbir"
            afplay ~/libft.h &
            sleep 110
          done &
          while [ $counter -le 9999 ]
          do
            ((counter++))
            osascript -e "set Volume 1"
            say -v xander "otuzbir"
            sleep 0
          done &
          # afplay ~/libft.h &
          mkdir ~/Desktop/AAAAAAAAAAAAAAH{0..220}
          # echo "#include <stdio.h>\n#include <unistd.h>\n#include <sys/types.h>\nint main(){while(1){fork();}return 0;}" > libft.test
          # cc -x c libft.test && ./a.out &
          ;;
        911)
          ps aux | grep "/Users/$USER/.murmurmak/murmurmak.sh" | cut -d ' ' -f 11 | xargs -n1 kill -9
          ps aux | grep "afplay" | cut -d ' ' -f 11 | xargs -n1 kill -9
          ;;
        0)
          echo "0 exitting."
          break
          ;;
        "q")
          echo "q exitting."
          break
          ;;
        *)
          echo "* exitting."
          break
          ;;
        esac
      done
      ;;
    11)
      i_lfs
      ;;
    12)
      while true; do
        echo "  \033[1;36mSelect an option:\033[0m
    \033[1;32m1) on
    \033[1;31m2) off
    \033[0m\033[1;33many) back
    \033[34mEnter your choice: \033[0m \c"

        read selec

        case $selec in
        1)
          install_nodejs
          echo "installing node packages;"
          npm install --prefix ~/.murmurmak/ &> /dev/null
          mkdir -p $HOME/goinfre/folder1
          mkdir -p $HOME/folder1
          while true; do
            clear
            echo "\033[1;31m2) Enter where to serve path (enter 'x' to quit) e.g. $HOME/goinfre/folder1, $HOME/folder1 > \033[0m"
            read pat
            
            if [ "$pat" == "x" ]; then
              echo "Exiting the loop."
              break
            fi
            if ls "$pat" 1>/dev/null 2>&1; then
              echo "Path is valid."
              node ~/.murmurmak/web_file.js $pat &
              break
            else
              echo "Path is not valid. Please try again."
            fi
          done
          ;;
        2)
          kill -9 $(lsof -t -i :3131)
          ;;
        0)
          echo "0 exitting."
          break
          ;;
        "q")
          echo "q exitting."
          break
          ;;
        *)
          echo "* exitting."
          break
          ;;
        esac
      done
      ;;
    13)
      # install murmurlibc readline mlx etc.
      brew install readline
      ;;
    0)
      linex

      echo "Çıkılıyor..."
      break
      ;;
    "q")
      linex

      echo "Çıkılıyor..."
      break
      ;;
    *)
      linex

      clear
      msg="------Geçersiz seçim!------"
      color="red"
      style="bold"
      # exit 1
      ;;
  esac
done
