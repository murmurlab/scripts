# Portable Installer Scripting Interface
i_utils()
{
  # install murmurlibc readline mlx etc.
  stat "waiting select..." "light_blue" "" "$b"
  stat2 "i_utils menu" "orange" "" "$m"
  while true; do
    clear

    top_banner "$msg" "$color" "$style" "$msg2" "$color2" "$style2" "$banner_i_utils"

    read -rn1 choice

    case $choice in
      'n') install_nodejs ;;
      'r') brew install readline ;;
      'q'|''|0) linex;clear;echo "Çıkılmak murmurbox pisi.";break;;
      *)
        # linex
        stat "invalid selection!" "red" "bold" "$b"
        # msg="3132123"
        # exit 1
        ;;
    esac
  done
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
      echo -e "\nexport PATH=\$PATH:$INSTALL_DIR/bin" >> "$shell_f"
    fi
  else
    echo "nodejs exist, cancel installing nodejs..."
  fi
}

i_7z()
{
  # Set the URL for the Node.js binary tarball
  NODEJS_URL="https://www.7-zip.org/a/7z2301-mac.tar.xz"

  # Define the destination directory for the Node.js binary
  INSTALL_DIR="$HOME/goinfre/7z"

  7z -v &> /dev/null
  if [ $? -eq 127 ]; then
    echo "7z not found, installing nodejs..."
    mkdir -p $INSTALL_DIR && curl $NODEJS_URL | tar Jx -C $INSTALL_DIR
    export PATH="$PATH:$INSTALL_DIR/"
    # PATH=$PATH:$INSTALL_DIR/bin
    if ! grep "\<export PATH=\$PATH:$INSTALL_DIR/\>" <"$shell_f" &>/dev/null; then
      echo -e "\nexport PATH=\$PATH:$INSTALL_DIR/" >> "$shell_f"
    fi
  else
    echo "7z exist, cancel installing nodejs..."
  fi
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
        echo -e "export PATH=\"$pat:\$PATH\"" >> $shell_f
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

install_brew()
{
  cecho "brew" "red" ""
  brew &> /dev/null
  if [ $? -eq 127 ]; then
    echo "brew not found, installing brew..."
    mkdir -p ~/goinfre/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/goinfre/homebrew
    export PATH=$PATH:~/goinfre/homebrew/bin
    PATH=$PATH:~/goinfre/homebrew/bin
    if ! grep "\<export PATH=\$PATH:~/goinfre/homebrew/bin\>" <"$shell_f" &>/dev/null; then
      echo -e "\nexport PATH=\$PATH:~/goinfre/homebrew/bin" >> "$shell_f"
    fi
  else
    cecho "ok" "red" ""
  fi
}

i_valgrind()
{
  cecho "volgraynd zaten olabilir :o" "yellow" ""
  install_brew
  brew tap LouisBrunner/valgrind
  brew install --HEAD LouisBrunner/valgrind/valgrind
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