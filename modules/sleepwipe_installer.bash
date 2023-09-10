git clone https://github.com/fleizean/sleepwipe.git ~/.sleepwipe || git -C ~/.sleepwipe pull && make -C ~/.sleepwipe
mkdir -p ~/.local/bin/ && cp ~/.sleepwipe/sleepwipe ~/.local/bin/
if ls "$HOME"/.local/bin/sleepwipe &>/dev/null; then
  echo -e "\n\033[32m -- sleepwipe has been successfully set! --\n\033[0m"
else
    echo "some error xd"
fi

if ! grep "\<export PATH=\$PATH:~/.local/bin\>" <"$shell_f" &>/dev/null; then
  echo -e "\nexport PATH=\$PATH:~/.local/bin/" >> "$shell_f"
fi
source $shell_f
sleepwipe -h
stat "installed" "yellow" ""