del_c()
{
  # 42 Caches
  /bin/rm -rf "$HOME"/Library/*.42* &>/dev/null &
  /bin/rm -rf "$HOME"/*.42* &>/dev/null &
  /bin/rm -rf "$HOME"/.zcompdump* &>/dev/null &
  /bin/rm -rf "$HOME"/.cocoapods.42_cache_bak* &>/dev/null &

  # Trash
  /bin/rm -rf "$HOME"/.Trash/* &>/dev/null &

  # General Caches files
  # Giving access rights to Homebrew caches, so the script can delete them
  /bin/chmod -R 777 "$HOME"/Library/Caches/Homebrew &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Caches/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Caches/* &>/dev/null &

  # Slack, VSCode, Discord, and Chrome Caches
  /bin/rm -rf "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Slack/Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Code\ Cache/js* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/discord/Crashpad/completed/*  &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Code/Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Code/CachedData/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Code/Crashpad/completed/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/* &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/* &>/dev/null &

  # .DS_Store files
  find "$HOME"/Desktop -name .DS_Store -depth -exec /bin/rm {} \; &>/dev/null &

  # Temporary downloaded files with browsers
  /bin/rm -rf "$HOME"/Library/Application\ Support/Chromium/Default/File\ System &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System &>/dev/null &
  /bin/rm -rf "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System &>/dev/null &

  # Things related to pool (piscine)
  /bin/rm -rf "$HOME"/Desktop/Piscine\ Rules\ *.mp4 &
  /bin/rm -rf "$HOME"/Desktop/PLAY_ME.webloc &
  wait
}

# echo "Maktemizlemek seçildi."
# Author: Omar BOUYKOURNE
# 42login: obouykou
banner
# Calculating the current available storage
Storage=`df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B'`
if [ "$Storage" == "0BB" ]; then
    Storage="0B"
fi
echo -e " \033[1;4;93m$Storage\033[0m \033[93m<< maktemizlemek baslamak \033[0m\n"

echo -e " \033[1;31mMAK_temizlemek_engine_release_1.0.1\033[0m \033[91mlaunching ...\033[0m"
echo -e " \033[1;90m temizleniyo ...\033[0m\n"

del_c

# Calculating the new available storage after cleaning
Storage=`df -h "$HOME" | grep "$HOME" | awk '{print($4)}' | tr 'i' 'B'`
if [ "$Storage" == "0BB" ]; then
    Storage="0B"
fi
echo -e " \033[32m\033[1m\033[4m$Storage\033[0m\033[32m << maktemizlemek basarili olmak \n"

echo -e "\n           \033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34mm\033[0;35mu\033[0;34mr\033[0;35mm\033[0;34mu\033[0;35mr\033[0;34m.\033[0m.\033[0;35m.\033[0m"
echo -e "GitHub \033[4;1;32mmurmurlab\033[0m\n"