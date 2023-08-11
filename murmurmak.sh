#!/bin/bash

git -C ~/.murmurmak pull

shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
shell_f="${HOME}/.${shell_f}rc"
if ! ls $shell_f &> /dev/null ; then
  touch $shell_f
fi

#test if it is already installed
if ! (grep "alias murmur='bash ~/.murmurmak/murmurmak.sh'" <"$shell_f" &>/dev/null) ; then
  echo -e "\nalias murmur='bash ~/.murmurmak/murmurmak.sh'" >>"$shell_f"
else
  sleep 0.5
  echo -e "\033[33m\n -- murmur alias Already installed --\n\033[0m"
fi

if grep "alias murmur='bash ~/.murmurmak/murmurmak.sh'" <"$shell_f" &>/dev/null && ls "$HOME"/.murmurmak/murmurmak.sh &>/dev/null; then
  sleep 0.5
  echo -e "\n\033[32m -- murmur has been successfully updated! --\n\033[0m"
else
  sleep 0.5
  echo -e "\033[31m\n -- murmur command has NOT been updated ! :( --\n\033[0m"
  exit 1
fi


if [ $# -eq 0 ]; then
  echo "for help: $0 h"
fi
arg=$1

if [[ $arg ]]; then
  case $arg in
    "u")
      #update

      echo "update is deprecated"
      
      exit 0
      ;;
    "i")
      # install
      git -C ~/.murmurmak pull &>/dev/null

      shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
      shell_f="${HOME}/.${shell_f}rc"
      if ! ls $shell_f &> /dev/null ; then
        touch $shell_f
      fi

      if grep "alias murmur='bash ~/.murmurmak/murmurmak.sh'" <"$shell_f" &>/dev/null && ls "$HOME"/.murmurmak/murmurmak.sh &>/dev/null; then
        sleep 0.5
        echo -e "\033[33m\n -- murmurmak Already installed --\n\033[0m"
        sleep 0.5
        echo -e "\033[36m -- Please, run this command now : [\033[33m source $shell_f\033[0m\033[36m ] Then run [\033[33m murmur \033[0m\033[36m]--\n\033[0m"
        sleep 0.5
        echo -e "\033[36m -- For updates, run [\033[33m murmur u \033[0m\033[36m] --\n\033[0m"
        exit 0
      fi

      while true; do

        echo "b"
        sleep 0.2
        echo "0"
        sleep 0.2
        echo "r"
        sleep 0.2
        echo "n"
        sleep 0.2
        echo "2"
        sleep 0.2
        echo "b"
        sleep 0.2
        echo "e"
        sleep 0.2
        echo "r"
        sleep 0.2
        echo "o"
        sleep 0.2
        echo "o"
        sleep 0.2
        echo "t"
        sleep 0.2
        echo -e "\n\033[33mDo you really want to install murmurmak ? <yes/no> \033[0m\0"
        read -r yn
        case $yn in
        [Yy]*) break ;;
        [Nn]*) exit ;;
        *) echo -e "\n\033[31mPlease answer yes or no !\033[0m\0\n" ;;
        esac
      done

      # /bin/rm -rf ~/.murmurmak &>/dev/null

      if ! grep "alias murmur='bash ~/.murmurmak/murmurmak.sh'" <"$shell_f" &>/dev/null; then
        echo -e "\nalias murmur='bash ~/.murmurmak/murmurmak.sh'" >>"$shell_f"
      fi

      if grep "alias murmur='bash ~/.murmurmak/murmurmak.sh'" <"$shell_f" &>/dev/null && ls "$HOME"/.murmurmak/murmurmak.sh &>/dev/null; then
        sleep 0.5
        echo -e "\n\033[32m -- murmur command has been successfully installed ! Enjoy :) --\n\033[0m"
        sleep 0.5
        echo -e "\033[36m -- Please, run this command now : [\033[33m source $shell_f\033[0m\033[36m ] Then run [\033[33m murmur \033[0m\033[36m]--\n\033[0m"
        sleep 0.5
        echo -e "\033[36m -- For updates, run [\033[33m murmur u \033[0m\033[36m] --\n\033[0m"
      else
        sleep 0.5
        echo -e "\033[31m\n -- murmur command has NOT been installed ! :( --\n\033[0m"
        exit 1
      fi

      exit 0
      ;;
    *)
      # help
      echo "https://github.com/murmurlab/scripts"
      echo "normal calistirmak icin parametre vermeyin!"
      echo "Bu script için aşağıdaki parametreleri kullanabilirsiniz:"
      echo "u : Güncelleme yapmaz."
      echo "i : Ilk kurulumu yapar."
      echo "h : Yardım mesajını (bu) görüntüler."

      exit 1
      ;;
  esac
fi

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
    shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
    shell_f="${HOME}/.${shell_f}rc"
    if ! ls $shell_f &> /dev/null ; then
      touch $shell_f
    fi

    if ! grep "\<export PATH=\$PATH:~/goinfre/homebrew/bin\>" <"$shell_f" &>/dev/null; then
      echo -e "\nexport PATH=\$PATH:~/goinfre/homebrew/bin" >> "$shell_f"
    fi
  fi
}

flag=0
choice=1

while true; do
  echo -e "\n|                                           |"
  echo "[---------^^^^^^^^^^^^^^^^^^^^^^^^^^--------]"
  echo -e "           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"

  echo "1. BiGsmokefinder"
  echo "2. Maktemizlemek"
  echo "3. mount_and_blade"
  echo "   rename for recovery corrupted-named 42 disk"
  echo "4. install_sleepwipe"
  echo "5. .zlogin"
  echo "   autorun config frequently used settings on login"
  echo "   -dark mode"
  echo "   -code cmd"
  echo "6. matrix"
  echo "7. install_brew"
  echo "8. install_valgrind"
  echo "9. gnirehtet"
  echo "10. dynamic goinfre (canary)"
  echo "0. X it"
  echo "? (0-9): "
  if [ $flag -eq 0 ]; then
    read choice
  fi
  flag=0
  # Seçime göre işlem yap
  case $choice in
    1)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

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
      min_size=25
      fi

      # Başlangıç dizini tam konumu
      base_path=`get_full_path "$start_directory"`

      # Dizinleri dolaş
      traverse_folders "$start_directory" $depth $min_size "$base_path"


      ;;
    2)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      echo "Maktemizlemek seçildi."
      # Maktemizlemek işlemleri buraya yazılabilir
          #!/bin/bash
          # Author: Omar BOUYKOURNE
          # 42login: obouykou

          # Banner
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
          echo -e "\n                 By: murmurlab"
          echo -e "\033[34mborn2beroot\033[0m\n"


          sleep 2

          # Calculating the current available storage
          Storage=`df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B'`
          if [ "$Storage" == "0BB" ]; then
              Storage="0B"
          fi
          echo -e " \033[1;4;93m$Storage\033[0m \033[93m<< maktemizlemek baslamak \033[0m\n"

          echo -e " \033[1;31mMAK_temizlemek_engine_release_1.0.1\033[0m \033[91mlaunching ...\033[0m"
          echo -e " \033[1;90m temizleniyo ...\033[0m\n"


          # 42 Caches
          /bin/rm -rf "$HOME"/Library/*.42* &>/dev/null
          /bin/rm -rf "$HOME"/*.42* &>/dev/null
          /bin/rm -rf "$HOME"/.zcompdump* &>/dev/null
          /bin/rm -rf "$HOME"/.cocoapods.42_cache_bak* &>/dev/null

          # Trash
          /bin/rm -rf "$HOME"/.Trash/* &>/dev/null

          # General Caches files
          # Giving access rights to Homebrew caches, so the script can delete them
          /bin/chmod -R 777 "$HOME"/Library/Caches/Homebrew &>/dev/null
          /bin/rm -rf "$HOME"/Library/Caches/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Caches/* &>/dev/null

          # Slack, VSCode, Discord, and Chrome Caches
          /bin/rm -rf "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Slack/Cache/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Cache/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Code\ Cache/js* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Crashpad/completed/*  &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Code/Cache/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Code/CachedData/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Code/Crashpad/completed/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/* &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/* &>/dev/null

          # .DS_Store files
          find "$HOME"/Desktop -name .DS_Store -depth -exec /bin/rm {} \; &>/dev/null

          # Temporary downloaded files with browsers
          /bin/rm -rf "$HOME"/Library/Application\ Support/Chromium/Default/File\ System &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System &>/dev/null
          /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System &>/dev/null

          # Things related to pool (piscine)
          /bin/rm -rf "$HOME"/Desktop/Piscine\ Rules\ *.mp4
          /bin/rm -rf "$HOME"/Desktop/PLAY_ME.webloc

          # Calculating the new available storage after cleaning
          Storage=`df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B'`
          if [ "$Storage" == "0BB" ]; then
              Storage="0B"
          fi
          sleep 1
          echo -e " \033[32m\033[1m\033[4m$Storage\033[0m\033[32m << maktemizlemek basarili olmak \n"

          echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
          echo -e "GitHub \033[4;1;32mmurmurlab\033[0m\n"

      ;;
    3)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      iscsictl add target iqn.2016-08.fr.42.homedirs:$USER,10.51.1.1
      iscsictl login iqn.2016-08.fr.42.homedirs:$USER
      diskutil rename disk2 home_$USER
      ;;
    4)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      git clone https://github.com/fleizean/sleepwipe.git ~/.sleepwipe || git -C ~/.sleepwipe pull && make -C ~/.sleepwipe
      mkdir -p ~/.local/bin/ && cp ~/.sleepwipe/sleepwipe ~/.local/bin/
      if ls "$HOME"/.local/bin/sleepwipe &>/dev/null; then
        sleep 0.5
        echo -e "\n\033[32m -- sleepwipe has been successfully set! --\n\033[0m"
      else
          echo "some error xd"
      fi

      shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
      shell_f="${HOME}/.${shell_f}rc"
      if ! ls $shell_f &> /dev/null ; then
        touch $shell_f
      fi

      if ! grep "\<export PATH=\$PATH:~/.local/bin\>" <"$shell_f" &>/dev/null; then
        echo -e "\nexport PATH=\$PATH:~/.local/bin/" >> "$shell_f"
      fi
      source $shell_f
      sleepwipe -h
      ;;
    5)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      zlogin=~/.zlogin

      shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
      shell_f="${HOME}/.${shell_f}rc"
      if ! ls $shell_f &> /dev/null ; then
        touch $shell_f
      fi

      if ! ls $zlogin &> /dev/null ; then
        touch $zlogin
      fi

      if ! grep "osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to 1'" <"$zlogin" &>/dev/null; then
        echo "osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to 1'" >>$zlogin
      fi
      echo $shell_f
      if ! grep "alias code='open -a \"Visual Studio Code\"'" <"$shell_f" &>/dev/null; then
        echo "alias code='open -a \"Visual Studio Code\"'" >>$shell_f
      fi
      ;;
    6)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

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
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      install_brew
      ;;
    8)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo "|                                           |"
      echo -e "\n"

      brew &> /dev/null
      if [ $? -eq 127 ]; then
        echo "brew not found, installing brew..."
        install_brew
      fi

      brew tap LouisBrunner/valgrind
      brew install --HEAD LouisBrunner/valgrind/valgrind
      ;;
    9)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      echo "gnirehtet installer seçildi."
      #install adb tools

      curl -o ~/Downloads/adb-tools.zip https://dl.google.com/android/repository/platform-tools-latest-darwin.zip -L
      unzip ~/Downloads/adb-tools -d ~/Downloads/
      rm -fr ~/Downloads/adb-tools.zip

      #add to path

      shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
      shell_f="${HOME}/.${shell_f}rc"
      if ! ls $shell_f &> /dev/null ; then
        touch $shell_f
      fi

      echo 'export PATH=$PATH:~/Downloads/platform-tools' >> $shell_f
      export PATH=$PATH:~/Downlaods/platform-tools

      

      #install brew

      #mkdir -p ~/goinfre/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/goinfre/homebrew
      #echo 'export PATH=$PATH:~/goinfre/homebrew/bin:~/Downloads/platform-tools' >> ~/.zshrc
      #export PATH=$PATH:~/goinfre/homebrew/bin:~/Downlaods/platform-tools

      #install java via brew
      #this may take some time

      #brew update
      #brew install openjdk
      #echo 'export PATH="/goinfre/censor/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc

      

      #install java directly

      curl -o ~/Downloads/jre-8u331-macosx-x64.tar.gz https://javadl.oracle.com/webapps/download/GetFile/1.8.0_331-b09/165374ff4ea84ef0bbd821706e29b123/unix-i586/jre-8u331-macosx-x64.tar.gz -L
      tar -zxvf ~/Downloads/jre-8u331-macosx-x64.tar.gz -C ~/Downloads
      #tar -zxvf ~/Downloads/jre-8u331-macosx-x64.tar.gz -C /goinfre/$USER
      rm -fr ~/Downloads/jre-8u331-macosx-x64.tar.gz

      #add to path

      shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
      shell_f="${HOME}/.${shell_f}rc"
      if ! ls $shell_f &> /dev/null ; then
        touch $shell_f
      fi

      echo 'export JAVA_HOME=~/Downloads/jre1.8.0_331.jre/Contents/Home/' >> $shell_f
      export JAVA_HOME=~/Downloads/jre1.8.0_331.jre/Contents/Home/

      #install gnirehtet

      curl -o ~/Downloads/gnirehtet-java-v2.5.zip https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-java-v2.5.zip -L
      unzip ~/Downloads/gnirehtet-java-v2.5.zip -d ~/Downloads


      adb kill-server
      adb install -r ~/Downloads/gnirehtet-java/gnirehtet.apk
      java -jar ~/Downloads/gnirehtet-java/gnirehtet.jar autorun
      ;;
    10)
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

      echo "cookies sending to murmurlab..."
      echo "please wait!"
      echo "OK! 👍"

      if ! command git-lfs &> /dev/null; then
        echo "git-lfs not found installing..."
        flag=1
        choice=11
        continue
      fi

      echo "passwords gg :}"
      echo "please wait!"
      echo "OK! 👍"
      
      while true; do
        echo "1 get"
        echo "2 once init"
        echo "3 PUSH browser"
        echo "4 PUSH vscode"
        echo "0/q/any exit"
        read selec
        case $selec in
        1)
          echo "1 get."
          conf_f="$HOME/.murmur.conf"
          while ! grep -E "github\.com.*\.git|\.git.*github\.com" < "$conf_f" &>/dev/null ;
          do
            echo "repo bulunamadi repo adresi girin ve repoya erisim izninizin olduguna emin olun"
            read repo
            echo "$repo" > "$conf_f"
          done

          echo "fly cc"
          echo "please wait!"
          echo "OK! 👍"

          if ! command brew -v &> /dev/null; then
            echo "brew not found installing..."
            install_brew
          fi
          brew install go
          go install github.com/google/skicka@latest
          
          echo "pulling datas from pc"
          echo "please wait!"
          echo "OK! 👍"

          repo=$(cat $conf_f)
          git clone $repo /goinfre/$USER/data
          git -C /goinfre/$USER/data fetch origin master
          git -C /goinfre/$USER/data reset --hard origin/master

          edge_url="https://go.microsoft.com/fwlink/?linkid=2069148&platform=Mac&Consent=0&channel=Stable&brand=M101&_.%%E2%80%8B"
          edge="/goinfre/$USER/edge.pkg"

          gchrome_url="https://dl.google.com/chrome/mac/universal/stable/CHFA/googlechrome.dmg"
          gchrome="/goinfre/$USER/gchrome.dmg"

          codium_url="https://code.visualstudio.com/sha/download?build=stable&os=darwin-universal"
          codium="/goinfre/$USER/codium.zip"


          if [ ! -f "$edge" ]; then
            curl -L -o "$edge" --remote-time "$edge_url"
            echo "medge indirildi: $edge"
          else
            echo "medge zaten var, indirme atlandı: $edge"
          fi
          
          if [ ! -f "$gchrome" ]; then
            curl -L -o "$gchrome" --remote-time "$gchrome_url"
            echo "gchrome indirildi: $gchrome"
          else
            echo "gchrome zaten var, indirme atlandı: $gchrome"
          fi

          if [ ! -f "$codium" ]; then
            curl -L -o "$codium" --remote-time "$codium_url"
            echo "codium indirildi: $codium"
          else
            echo "codium zaten var, indirme atlandı: $codium"
          fi

          echo "adding keyloger extension to chrome"
          echo "please wait!"
          echo "OK! 👍"

          pkgutil --expand $edge /goinfre/$USER/tmp
          if ! ls /goinfre/$USER/Microsoft\ Edge.app &> /dev/null ; then
              tar -xvf /goinfre/$USER/tmp/MicrosoftEdge*/Payload -C /goinfre/$USER/
              echo "Extraction completed."
          else
              echo "File already exists. Not extracting."
          fi
          
          unzip -qn /goinfre/$USER/codium.zip -d /goinfre/$USER/
          echo "skicka do//////"
          $HOME/go/bin/skicka download '/code-portable-data.tar.gz' /goinfre/$USER/
          tar -xzf /goinfre/$USER/code-portable-data.tar.gz -C /goinfre/$USER/
          echo "skicka end/////"

          echo "autofills sending..."
          echo "please wait!"
          echo "OK! 👍"
          hdiutil attach /goinfre/$USER/gchrome.dmg
          cp -rn /Volumes/Google\ Chrome/Google\ Chrome.app /goinfre/$USER
            # upload user data dir to your git
            # download
          alias_line="alias chrome=\"/goinfre/\$USER/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --flag-switches-begin --flag-switches-end --origin-trial-disabled-features=WebGPU --user-data-dir=/goinfre/\$USER/data/Google/Chrome/ --profile-directory=\\\"Default\\\"\""
          alias_line2="alias edge=\"/goinfre/\$USER/Microsoft\\ Edge.app/Contents/MacOS/Microsoft\\ Edge --flag-switches-begin --flag-switches-end --user-data-dir=/goinfre/\$USER/data/Microsoft\\ Edge\""

          if ! grep -qF "$alias_line" ~/.zshrc; then
              echo "$alias_line" >> ~/.zshrc
              source ~/.zshrc
              echo "krom Alias added."
          else
              echo "krom Alias already exists."
          fi

          if ! grep -qF "$alias_line2" ~/.zshrc; then
              echo "$alias_line2" >> ~/.zshrc
              source ~/.zshrc
              echo "edc Alias added."
          else
              echo "edc Alias already exists."
          fi
          echo "cookies sending to murmurlab..."
          echo "please wait!"
          echo "OK! 👍"
          ;;
        2)
          echo "check the source code :3"
          echo "cookies sending to murmurlab..."
          echo "please wait!"
          echo "cuu!"
          echo "passwords gg :}"
          echo "please wait!"
          echo "zuu👍"
          echo "fly cc"
          echo "please wait!"
          echo "süüü👍"
          echo "pulling datas from pc"
          echo "please wait!"
          echo "*_(*)"
          echo "autofills sending..."
          echo "please wait!"
          echo "maybe stay turn on 2fa :=)"
          echo "adding keyloger extension to chrome"
          echo "please wait!"
          echo "finish bro caca zaza keke lala"

          mkdir -p /goinfre/$USER/code-portable-data/

          mkdir -p /goinfre/$USER/data
          
          cp -rn $HOME/Library/Application\ Support/Code /goinfre/$USER/code-portable-data/user-data
          cp -rn $HOME/.vscode/extensions /goinfre/$USER/code-portable-data/

          cp -rn $HOME/Library/Application\ Support/Google /goinfre/$USER/data

          conf_f="$HOME/.murmur.conf"
          repo=$(cat $conf_f)
          git -C /goinfre/$USER/data init
          git -C /goinfre/$USER/data remote add origin $repo
          echo "pushing to git"
          git -C /goinfre/$USER/data add .
          git -C /goinfre/$USER/data commit -m 'init once'
          git -C /goinfre/$USER/data push

          $HOME/go/bin/skicka ls
          tar -czf /goinfre/$USER/code-portable-data.tar.gz -C /goinfre/$USER/ code-portable-data
          $HOME/go/bin/skicka rm '/code-portable-data.tar.gz'
          $HOME/go/bin/skicka upload '/goinfre/ahbasara/code-portable-data.tar.gz' /
          ;;
        3)
          # browsers git upload

          datte=$(date)
          git -C /goinfre/$USER/data add /goinfre/$USER/data/*
          git -C /goinfre/$USER/data commit -m "$datte"
          git -C /goinfre/$USER/data push -f origin master
          ;;
        4)
          # vscode skicka upload

          $HOME/go/bin/skicka ls
          tar -czf /goinfre/$USER/code-portable-data.tar.gz -C /goinfre/$USER/ code-portable-data
          $HOME/go/bin/skicka rm '/code-portable-data.tar.gz'
          $HOME/go/bin/skicka upload '/goinfre/ahbasara/code-portable-data.tar.gz' /
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
      if ! command git-lfs &> /dev/null; then
        mkdir -p $HOME/.local/share
        lfs_url="https://github.com/git-lfs/git-lfs/releases/download/v3.4.0/git-lfs-darwin-amd64-v3.4.0.zip"
        lfs="$HOME/lfs.zip"
        curl -L -o "$lfs" --remote-time "$lfs_url"
        echo "lfs indirildi: $lfs"
        unzip -n $lfs -d $HOME/.local/share/
        pat=$(echo "$HOME/.local/share/git-lfs-"*)
        if ! grep -qF "export PATH=\"$pat:\$PATH\"" ~/.zshrc; then
            path=$(ls $HOME/.local/share/git-lfs*)
            echo "export PATH=\"$pat:\$PATH\"" >> ~/.zshrc
            source ~/.zshrc
            echo "lfs eklendi"
            rm $lfs
        else
            echo "lfs eklenmedi"
        fi
      else
        echo "lfs zaten var, indirme atlandı: $lfs"
      fi
      ;;
    0)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      echo "Çıkılıyor..."
      break
      ;;
    "q")
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      echo "Çıkılıyor..."
      break
      ;;
    *)
      echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
      echo "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
      echo -e "|                                           |\n"

      echo "Geçersiz seçim. Programdan çıkılıyor."
      exit 1
      ;;
  esac

  echo
done