linex()
{
  echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
  echo -e "[--------⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄⌄---------]"
  echo -e "|                                           |\n"
}

top_banner()
{
  cecho "for help: $0 h" "green" "reversed"
  cecho "$1" $2 $3
  echo -e "[=============================murmur_client_$ver==============================]"
  echo -e "           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"

  echo -e "\033[1;32mSelect an option:\033[0m
  \033[1;34m(z, 2, 3, 4, 8, 9) empty\033[0m
  \033[1;33ml. logger\033[0m
  \033[1;33mf. find_fat\033[0m
  \033[1;33mc. Maktemizlemek\033[0m
  \033[1;33mi. mount_and_blade (rename for recovery corrupted-named 42 disk)\033[0m
  \033[1;33ms. install_sleepwipe\033[0m
  \033[1;33mm. matrix\033[0m
  \033[1;33m1. install_brew\033[0m
  \033[1;33mv. install_valgrind\033[0m
  \033[1;33m7. gnirehtet\033[0m
  \033[1;33mx. dynamic goinfre (canary)\033[0m
  \033[1;33m6. i_lfs\033[0m
  \033[1;33mw. web_explorer\033[0m
  \033[1;33m5. i_utils\033[0m
  \033[1;31m(q|0|''). Çıkılmak murmurbox.\033[0m
  \033[1;32m(?) :\033[0m \c"

}

banner()
{
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
  echo -e "\n                 By: obouykou->murmurlab"
  echo -e "\033[34mborn2beroot\033[0m\n"
}

cecho()
{
    local text="$1"
    local color_name="$2"
    local style="$3"
    local color_code=""
    local style_code=""

    case "$color_name" in
        "black") color_code="30";;
        "red") color_code="31";;
        "green") color_code="32";;
        "yellow") color_code="33";;
        "blue") color_code="34";;
        "magenta") color_code="35";;
        "orange") color_code="36";;
        "gray") color_code="90";;
        "light_red") color_code="91";;
        "light_green") color_code="92";;
        "light_yellow") color_code="93";;
        "light_blue") color_code="94";;
        "pink") color_code="95";;
        "light_orange") color_code="96";;
        "white") color_code="97";;
        *) color_code="97";;
    esac

    case "$style" in
        "bold") style_code="1";;
        "underline") style_code="4";;
        "reversed") style_code="7";;
        *) style_code="0";;  # Normal stil
    esac

    echo -e "\033[${style_code};${color_code}m${text}\033[0m"
}

insert()
{
  echo "${b:0:1}$1${b:${#1}+1}"
}

stat()
{
  msg="$(insert "$1")"
  color=$2
  style=$3
}

murlog()
{
        echo -e "[`date +'%Y/%m/%d %H:%M:%S%s'`]: $1"  >> "$2"
}