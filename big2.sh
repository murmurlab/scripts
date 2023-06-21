#!/bin/bash

get_full_path() {
  local path=$1
  local full_path=$(cd "$path" && pwd)
  echo "$full_path"
}

traverse_folders() {
  local directory=$1
  local depth=$2
  local min_size=$3
  local base_path=$4

  local directories=()

  for file in "$directory"/*; do
    if [ -d "$file" ]; then
      local sub_directory=$(basename "$file")
      local size=$(du -sm "$file" 2>/dev/null | awk '{print $1}')

      if [ -n "$size" ] && [ $size -ge $min_size ]; then
        local full_path="${base_path%/}/$sub_directory"
        directories+=("$full_path:$size")
      fi

      if [ $depth -gt 1 ]; then
        traverse_folders "$full_path" $((depth - 1)) $min_size "$base_path"
      fi
    fi
  done

  IFS=$'\n' sorted_directories=($(sort -t ':' -k 2nr <<<"${directories[*]}"))

  for entry in "${sorted_directories[@]}"; do
    local full_path=$(cut -d ':' -f 1 <<<"$entry")
    local size=$(cut -d ':' -f 2 <<<"$entry")
    echo "Dizin: $full_path, Boyut: ${size}MB"
  done
}

# Seçenek menüsü
echo "1. BiGsmokefinder"
echo "2. Maktemizlemek"
echo -n "Seçiminizi yapın (1-2): "
read choice

case $choice in
  1)
    echo -n "[Aramak istediğiniz dizini girin] (isteğe bağlı): "
    read start_directory

    if [ -z "$start_directory" ]; then
      start_directory="$HOME"
    elif [ "$start_directory" == "~" ]; then
      start_directory="$HOME"
    fi

    echo -n "[Dizinlerin derinliği]: "
    read depth
    if [ -z "$depth" ]; then
      depth=3
    fi

    echo -n "[Min boyut] (MB): "
    read min_size
    if [ -z "$min_size" ]; then
      min_size=25
    fi

    base_path=$(get_full_path "$start_directory")

    traverse_folders "$start_directory" $depth $min_size "$base_path"
    ;;
  2)
    echo "Maktemizlemek seçildi."
    # Maktemizlemek işlemleri buraya yazılabilir
    ;;
  *)
    echo "Geçersiz seçim. Programdan çıkılıyor."
    exit 1
    ;;
esac
