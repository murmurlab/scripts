alias1()
{
  alias_line="alias chrome=\"/goinfre/\$USER/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --flag-switches-begin --flag-switches-end --origin-trial-disabled-features=WebGPU --user-data-dir=/goinfre/\$USER/data/Google/Chrome/ --profile-directory=\\\"Default\\\"\""
  alias_line2="alias edge=\"/goinfre/\$USER/Microsoft\\ Edge.app/Contents/MacOS/Microsoft\\ Edge --flag-switches-begin --flag-switches-end --user-data-dir=/goinfre/\$USER/data/Microsoft\\ Edge\""
  alias_line3="alias kode=\"/goinfre/\$USER/Visual\\ Studio\\ Code.app/Contents/MacOS/Electron\""
  alias_line4="alias st4=\"/goinfre/\$USER/Sublime\\ Text.app/Contents/MacOS/sublime_text\""
  alias_line5="alias emacs=\"/Applications/Emacs.app/Contents/MacOS/Emacs -nw\""
  alias_line6="alias code='open -a \"Visual Studio Code\"'"

  if ! grep -qF "$alias_line6" $shell_f; then
    echo -e "\n$alias_line6" >> $shell_f
    source $shell_f
    # cecho "code Alias added." "gray" ""
  else
    ``
    # cecho "code Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line5" $shell_f; then
    echo -e "\n$alias_line5" >> $shell_f
    source $shell_f
    # cecho "emacs Alias added." "gray" ""
  else
    ``
    # cecho "emacs Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line4" $shell_f; then
    echo -e "\n$alias_line4" >> $shell_f
    source $shell_f
    # cecho "st4 Alias added." "gray" ""
  else
    ``
    # cecho "st4 Alias already exists." "gray" ""
  fi
  if ! grep -qF "$alias_line3" $shell_f; then
    echo -e "\n$alias_line3" >> $shell_f
    source $shell_f
    # cecho "kode Alias added." "gray" ""
  else
    ``
    # cecho "kode Alias already exists." "gray" ""
  fi

  if ! grep -qF "$alias_line" $shell_f; then
    echo -e "\n$alias_line" >> $shell_f
    source $shell_f
    # cecho "krom Alias added." "gray" ""
  else
    ``
    # cecho "krom Alias already exists." "gray" ""
  fi

  if ! grep -qF "$alias_line2" $shell_f; then
    echo -e "\n$alias_line2" >> $shell_f
    source $shell_f
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

