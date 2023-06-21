#!/bin/bash

if [ $# -eq 0 ]; then
  echo "for help: $0 h"
fi
arg=$1

if [[ $arg ]]; then
  case $arg in
    "u")
      #update

      git -C ~/.murmurmak pull &>/dev/null

      shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
      shell_f="${HOME}/.${shell_f}rc"

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
      
      exit 0
      ;;
    "i")
      # install
      git -C ~/.murmurmak pull &>/dev/null

      shell_f=`echo -n "$SHELL" | awk -F / '{print $3}'`
      shell_f="${HOME}/.${shell_f}rc"

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
        echo -en "\n\033[33mDo you really want to install murmurmak ? \033[0m\0"
        read -r yn
        case $yn in
        [Yy]*) break ;;
        [Nn]*) exit ;;
        *) echo -e "\n\033[31mPlease answer yes or no !\033[0m\0\n" ;;
        esac
      done

      /bin/rm -rf ~/.murmurmak &>/dev/null

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
      echo "u : Güncelleme yapar."
      echo "i : Ilk kurulumu yapar."
      echo "h : Yardım mesajını (bu) görüntüler."

      exit 1
      ;;
  esac
fi

get_full_path() {
  local path=$1
  local full_path=$(cd "$path" && pwd)
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
      local sub_directory=$(basename "$file")
      local size=$(du -sm "$file" 2>/dev/null | awk '{print $1}')

      # Min boyuttan büyük olanları diziye ekle
      if [ -n "$size" ] && [ $size -ge $min_size ]; then
        local full_path="${base_path%/}/$sub_directory"
        directories+=("$full_path:$size")  # Dizini diziye ekle: "dizin:boyut" formatında
      fi
    fi
  done

  # Dizileri boyuta göre sırala
  IFS=$'\n' sorted_directories=($(sort -t ':' -k 2nr <<<"${directories[*]}"))

  # Sıralanmış dizinleri ekrana yazdır
  for entry in "${sorted_directories[@]}"; do
    local full_path=$(cut -d ':' -f 1 <<<"$entry")
    local size=$(cut -d ':' -f 2 <<<"$entry")
    echo "Dizin: $full_path, Boyut: ${size}MB"

    if [ $depth -gt 1 ]; then
      traverse_folders "$full_path" $((depth - 1)) $min_size "$full_path"
    fi
  done
}


while true; do

  echo "1. BiGsmokefinder"
  echo "2. Maktemizlemek"
  echo "3. gnirehted installer"
  echo "4. rename for recovery corrupted-named 42 disk"
  echo "0. Çıkış"
  echo -n "Seçiminizi yapın (0-4): "
  read choice

  # Seçime göre işlem yap
  case $choice in
    1)
      echo -n "[Aramak istediğiniz dizini girin] (istege bagli): "
      read start_directory

      if [ -z "$start_directory" ]; then
      start_directory="$HOME"
      elif [ "$start_directory" == "~" ]; then
      start_directory="$HOME"
      fi

      echo -n "[Dizinlerin derinliği]: "
      read depth
      if [ -z "$depth" ]; then
      depth=3
      fi

      echo -n "[Min boyut] (MB): "
      read min_size
      if [ -z "$min_size" ]; then
      min_size=25
      fi

      # Başlangıç dizini tam konumu
      base_path=$(get_full_path "$start_directory")

      # Dizinleri dolaş
      traverse_folders "$start_directory" $depth $min_size "$base_path"


      ;;
    2)
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
          echo -en "\n                 By: "
          echo -e "\033[34mborn2beroot\033[0m\n"


          sleep 2

          # Calculating the current available storage
          Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
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
          Storage=$(df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B')
          if [ "$Storage" == "0BB" ]; then
              Storage="0B"
          fi
          sleep 1
          echo -e " \033[32m\033[1m\033[4m$Storage\033[0m\033[32m << maktemizlemek basarili olmak \n"

          echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
          echo -e "GitHub \033[4;1;32mmurmurlab\033[0m\n"

      ;;
    3)
      echo "gnirehtet installer seçildi."
      #install adb tools

      curl -o ~/Downloads/adb-tools.zip https://dl.google.com/android/repository/platform-tools-latest-darwin.zip -L
      unzip ~/Downloads/adb-tools -d ~/Downloads/
      rm -fr ~/Downloads/adb-tools.zip

      #add to path

      echo 'export PATH=$PATH:~/Downloads/platform-tools' >> ~/.zshrc
      export PATH=$PATH:~/Downlaods/platform-tools

      :'

      #install brew

      mkdir -p ~/goinfre/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/goinfre/homebrew
      echo 'export PATH=$PATH:~/goinfre/homebrew/bin:~/Downloads/platform-tools' >> ~/.zshrc
      export PATH=$PATH:~/goinfre/homebrew/bin:~/Downlaods/platform-tools

      #install java via brew
      #this may take some time

      brew update
      brew install openjdk
      echo 'export PATH="/goinfre/censor/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc

      '

      #install java directly

      curl -o ~/Downloads/jre-8u331-macosx-x64.tar.gz https://javadl.oracle.com/webapps/download/GetFile/1.8.0_331-b09/165374ff4ea84ef0bbd821706e29b123/unix-i586/jre-8u331-macosx-x64.tar.gz -L
      tar -zxvf ~/Downloads/jre-8u331-macosx-x64.tar.gz -C ~/Downloads
      #tar -zxvf ~/Downloads/jre-8u331-macosx-x64.tar.gz -C /goinfre/$USER
      rm -fr ~/Downloads/jre-8u331-macosx-x64.tar.gz

      #add to path

      echo 'export JAVA_HOME=~/Downloads/jre1.8.0_331.jre/Contents/Home/' >> ~/.zshrc
      export JAVA_HOME=~/Downloads/jre1.8.0_331.jre/Contents/Home/

      #install gnirehtet

      curl -o ~/Downloads/gnirehtet-java-v2.5.zip https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-java-v2.5.zip -L
      unzip ~/Downloads/gnirehtet-java-v2.5.zip -d ~/Downloads


      adb kill-server
      adb install -r ~/Downloads/gnirehtet-java/gnirehtet.apk
      java -jar ~/Downloads/gnirehtet-java/gnirehtet.jar autorun

      ;;
    4)
      iscsictl add target iqn.2016-08.fr.42.homedirs:$USER,10.51.1.1
      iscsictl login iqn.2016-08.fr.42.homedirs:$USER
      diskutil rename disk2 home_$USER
      ;;
    0)
      echo "Çıkılıyor..."
      break
      ;;
    *)
      echo "Geçersiz seçim. Programdan çıkılıyor."
      exit 1
      ;;
  esac

  echo
done