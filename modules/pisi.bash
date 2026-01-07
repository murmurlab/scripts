# urls
url_murmureval='https://github.com/lab-murmur-land/murmur.eval.git'
url_murminette='https://github.com/murmurlab/murminette.git'

# dirs
dir_apps=~/.local/share/
dir_bin=~/.local/bin/
dir_libs=~/.local/lib/
inc_libs=~/.local/include/


launch_app(){
	cd "$dir_apps/$1/"
	echo "$dir_apps/$1/$2" "${@:3}"
	# sleep 1
	# echo "Launching 3..."
	# sleep 1
	# echo "Launching 2..."
	# sleep 1
	# echo "Launching 1..."
	# sleep 1
	bash "$dir_apps/$1/$2" "${@:3}"
	# bash /home/ahmbasar/murminette/murmurinet.bash "${@:3}"
	cd -
	# exit $?;
}

# Portable Installer Scripting Interface
i_utils()
{
  # install murmurlibc readline mlx etc.
  stat "waiting select..." "light_blue" "" "$b"
  stat2 "i_utils menu" "orange" "" "$m"
  while true; do
    clear

    top_banner "$msg" "$color" "$style" "$msg2" "$color2" "$style2" "$banner_i_utils"

    read -rn2 choice

    case $choice in
      'n') install_nodejs ;;
      'r') brew install readline ;;
      'f') install_murminette ;;
	  'mm') i_murminette ;;
	  'tt') echo "hello"; sleep 1 ;;
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
u_murmureval()
{
	cecho "murmureval güncellemesi" "red" ""
	git -C "$dir_libs/$dir_libmurmureval" fetch origin stack-optimized &> /dev/null
	git -C "$dir_libs/$dir_libmurmureval" checkout origin/stack-optimized &> /dev/null
	git -C "$dir_libs/$dir_libmurmureval" pull origin stack-optimized &> /dev/null
	git -C "$dir_libs/$dir_libmurmureval" reset --hard origin/stack-optimized &> /dev/null
	make -C "$dir_libs/$dir_libmurmureval/murmur_eval/"
	cp "$dir_libs/$dir_libmurmureval/murmur_eval/build/libmurmureval.a" "$dir_libs/libmurmureval.a"
	cp "$dir_libs/$dir_libmurmureval/murmur_eval/incs/murmur_eval.hpp" "$inc_libs/murmur_eval.hpp"
}
i_murmureval()
{
	dir_libmurmureval='murmur.eval'
	cecho "murmureval kurulumu" "red" ""
	mkdir -p "$dir_libs"
	git -C "$dir_libs" clone $url_murmureval $dir_libmurmureval
	u_murmureval

}

u_murminette()
{
	bin_murminette='murmurinet.bash'
	cecho "murminette güncellemesi" "red" ""
	git -C "$dir_apps/$dir_murminette" fetch origin main &> /dev/null
	git -C "$dir_apps/$dir_murminette" checkout origin/main &> /dev/null
	git -C "$dir_apps/$dir_murminette" pull origin main &> /dev/null
	git -C "$dir_apps/$dir_murminette" reset --hard origin/main &> /dev/null
	# make -C "$dir_apps/$dir_murminette/" re
	# cp "$dir_apps/$dir_murminette/build/murminette" "$dir_bin/murminette"
	# ln -sf "$dir_apps/$dir_murminette/$bin_murminette" "$dir_bin/murminette"

}

i_murminette()
{
  i_murmureval
  dir_murminette='murminette'
  cecho "murminette tester kurulumu" "red" ""
  mkdir -p "$dir_apps"
  mkdir -p "$dir_bin"
  git -C "$dir_apps" clone $url_murminette $dir_murminette
  u_murminette
}

install_murminette(){
#   tee $rootmur/.tmp_bash <<_H
# bash -c "\$(curl https://raw.githubusercontent.com/murmurlab/francinette/refs/heads/murmurlab-docker/bin/dockerize/set-alias.bash)"
# _H

line="murminette(){ curl https://raw.githubusercontent.com/murmurlab/francinette/refs/heads/murmurlab-docker/bin/dockerize/Dockerfile | docker build -t murminette - && docker run -t --rm -v .:/tmp/proj murminette murminette \$@; }"
set_alias "$line" "$shell_f"
set_alias "$line" "$HOME/.zshrc" # unsupported
cecho "\nrun: bash -l" "red"
# line="alias murminette='docker run --rm -v .:/tmp/proj \`curl https://raw.githubusercontent.com/murmurlab/francinette/refs/heads/murmurlab-docker/bin/dockerize/Dockerfile | docker build -q -\`'"
# >>~/.bash_profile cat <<END
# $line
# END
# >>~/.zshrc cat <<END
# $line
# END
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
