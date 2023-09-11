
while true; do
  echo -e "  \033[1;36mSelect an option:\033[0m
\033[1;32m1) on
\033[1;31m2) off
\033[0m\033[1;33many) back
\033[34mEnter your choice: \033[0m \c"

  read selec

  case $selec in
  1)
    install_nodejs
    echo "installing node packages;"
    npm install --prefix ~/.murmurbox/ &> /dev/null
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
        node ~/.murmurbox/web_file.js $pat &
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