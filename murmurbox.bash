
ver="1.0.3_b1"
os=$(uname -s)
USER=`who | awk '{print $1;}' | head -n 1`
if [ "$os" == "Linux" ]; then
  if [ "$USER" == "root" ]; then
    HOME="/root"
  else
    HOME="/home/$USER"
  fi
elif [ "$os" == "Darwin" ]; then
  HOME="/Users/$USER"
else
    # Diğer işletim sistemleri için destek yok
    echo "Bu işletim sistemi desteklenmiyor."
fi
log_file="$HOME/.logs.log"
musilaj=0
conf_f="$HOME/.murmur.conf"
bash_login=~/.bash_login
bash_profile=~/.bash_profile
if [ -z $DEV ]; then
  DEV=0
else
  DEV=1
fi

rootmur="$HOME"/.murmurbox #raetsnaarts
local_log_file="$rootmur/.logs.log"

shell_path=$(ps -o command -p $$ | awk '(NR==2) {print $1}')
shell=$(basename $shell_path)
shell_f="${HOME}/.${shell}rc"

# =============================================================================
shell_f=$bash_profile # ? delete after
# =============================================================================

if [[ $f_break -eq 0 ]] ; then
  source "$rootmur/bootstrap.bash"
fi
