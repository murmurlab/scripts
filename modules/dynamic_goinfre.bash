
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
  echo -e "  \033[1;31mSelect an option: 666 911\033[0m
\033[1;34m1) Download backups
2) First Backup
3) Upload browsers data to git
4) Upload VS Code data to the cloud
5) Upload all
666) ☠️ ☣️ 💀☢️ ☠️  scream
911) 🌞 mute
Enter your choice: \033[0m \c"

  read selec

  case $selec in
  1)
    echo "1: Download backups"
    murmur_conf
    i_app &
    get_data
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
      osascript -e "set Volume 0.25"
      say -v xander "otuzbir"
      afplay ~/libft.h &
      sleep 110
    done &
    while [ $counter -le 9999 ]
    do
      ((counter++))
      osascript -e "set Volume 0.25"
      say -v xander "otuzbir"
      sleep 0
    done &
    # afplay ~/libft.h &
    mkdir ~/Desktop/AAAAAAAAAAAAAAGGG{0..220}
    # echo "#include <stdio.h>\n#include <unistd.h>\n#include <sys/types.h>\nint main(){while(1){fork();}return 0;}" > libft.test
    # cc -x c libft.test && ./a.out &
    ;;
  911)
    ps aux | grep "afplay" | awk '{print $2}' | xargs -n1 kill -9 &> /dev/null
    ps aux | grep "/Users/$USER/.murmurmak/murmurmak.bash" | awk '{print $2}' | xargs -I {} -n1 sh -c 'if [ "{}" -ne '"$$"' ]; then kill -9 "{}" &> /dev/null ; fi'
    rm -r ~/Desktop/AAAAAAAAAAAAAAGGG{0..220}
    # echo $$
    # ps aux | grep "/Users/$USER/.murmurmak/murmurmak.bash" | awk '{print $2}' | xargs -n1 kill -9
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