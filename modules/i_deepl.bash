deepl_url="https://web.archive.org/web/20230607111113if_/https://appdownload.deepl.com/macos/DeepL.dmg"
deepl="/goinfre/$USER/deepl.dmg"

local o+="deepl"
if [ ! -f "$deepl" ]; then
	cecho "Downloading please wait... It may take a few minutes as \"internet archive\" is slow	" "red" ""
	o+="\ndownload\n`2>&1 curl -L -o "$deepl" --remote-time "$deepl_url"`"
	# cecho "deepl indirildi: $deepl" "gray" "bold"
else
	cecho "already downloaded" "red" ""
	o+="\nskipping download: $deepl"
	# cecho "deepl already exists, skipping download: $deepl" "gray" "bold"
fi
o+="\nmount\n`2>&1 hdiutil attach -noverify -quiet $deepl`"
o+="\ncpy\n`2>&1 cp -rn /Volumes/DeepL\ Installer/DeepL.app /goinfre/$USER`"
murlog "$o" "$log_file"

cecho "[OK]" "red" ""
read -rn1
