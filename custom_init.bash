alias1()
{
  alias_line="alias chrome=\"/goinfre/$USER/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --flag-switches-begin --flag-switches-end --origin-trial-disabled-features=WebGPU --user-data-dir=/goinfre/\$USER/data/Google/Chrome/ --profile-directory=\\\"Default\\\"\""
  alias_line2="alias edge=\"/goinfre/$USER/Microsoft\\ Edge.app/Contents/MacOS/Microsoft\\ Edge --flag-switches-begin --flag-switches-end --user-data-dir=/goinfre/\$USER/data/Microsoft\\ Edge\""
  alias_line3="alias kode=\"/goinfre/$USER/Visual\\ Studio\\ Code.app/Contents/MacOS/Electron\""
  alias_line4="alias st4=\"/goinfre/$USER/Sublime\\ Text.app/Contents/MacOS/sublime_text\""
  alias_line5="alias emacs=\"/Applications/Emacs.app/Contents/MacOS/Emacs -nw\""
  alias_line6="alias code='open -a \"Visual Studio Code\"'"
  deepl="alias deepl=\"/goinfre/$USER/DeepL.app/Contents/MacOS/DeepL\""
  hom="export HOME=$HOME"
  usr="export HOME=$USER"
  go="PATH=\$PATH:$HOME/go/bin"

  if ! grep -qF "$go" $shell_f; then
    echo -e "\n$go" >> $shell_f
    # source $shell_f
    # cecho "go Alias added." "gray" ""
  else
    ``
    # cecho "go Alias already exists." "gray" ""
  fi

  if ! grep -qF "$hom" $shell_f; then
    echo -e "\n$hom" >> $shell_f
    # source $shell_f
    # cecho "hom Alias added." "gray" ""
  else
    ``
    # cecho "hom Alias already exists." "gray" ""
  fi
  if ! grep -qF "$usr" $shell_f; then
    echo -e "\n$usr" >> $shell_f
    # source $shell_f
    # cecho "usr Alias added." "gray" ""
  else
    ``
    # cecho "usr Alias already exists." "gray" ""
  fi


  if ! grep -qF "$alias_line6" $shell_f; then
    echo -e "\n$alias_line6" >> $shell_f
    # source $shell_f
    # cecho "code Alias added." "gray" ""
  else
    ``
    # cecho "code Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line5" $shell_f; then
    echo -e "\n$alias_line5" >> $shell_f
    # source $shell_f
    # cecho "emacs Alias added." "gray" ""
  else
    ``
    # cecho "emacs Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line4" $shell_f; then
    echo -e "\n$alias_line4" >> $shell_f
    # source $shell_f
    # cecho "st4 Alias added." "gray" ""
  else
    ``
    # cecho "st4 Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line3" $shell_f; then
    echo -e "\n$alias_line3" >> $shell_f
    # source $shell_f
    # cecho "kode Alias added." "gray" ""
  else
    ``
    # cecho "kode Alias already exists." "gray" ""
  fi

  if ! grep -qF "$alias_line" $shell_f; then
    echo -e "\n$alias_line" >> $shell_f
    # source $shell_f
    # cecho "krom Alias added." "gray" ""
  else
    ``
    # cecho "krom Alias already exists." "gray" ""
  fi

  if ! grep -qF "$deepl" $shell_f; then
    echo -e "\n$deepl" >> $shell_f
    # source $shell_f
    # cecho "deepl Alias added." "gray" ""
  else
    ``
    # cecho "deepl Alias already exists." "gray" ""
  fi

  if ! grep -qF "$alias_line2" $shell_f; then
    echo -e "\n$alias_line2" >> $shell_f
    # source $shell_f
    # cecho "edc Alias added." "gray" ""
  else
    ``
    # cecho "edc Alias already exists." "gray" ""
  fi
  murlog "added aliases" "$log_file"
}

customizator()
{
  string1="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to 1'"
  string2="export BASH_SILENCE_DEPRECATION_WARNING=1"

  # bash_profile

  if ! grep "$string2"<"$bash_profile"&>/dev/null; then
    echo $string2 >> $bash_profile
  fi
  # bash_profile

  if ! grep "$string1"<"$bash_profile"&>/dev/null; then
    echo $string1>>$bash_profile
  fi
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