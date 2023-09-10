get_full_path()
{
  local path=$1
  local full_path=`cd "$path" && pwd`
  echo "$full_path"
}

traverse_folders()
{
  local directory=$1
  local depth=$2
  local min_size=$3
  local base_path=$4

  local directories=()  # Dizinleri depolamak için boş bir dizi oluştur

  # Dizin içindeki dosyaları dolaş
  for file in "$directory"/*; do
    if [ -d "$file" ]; then
      # Eğer bir dizin ise, içine gir ve boyutu hesapla
      local sub_directory=`basename "$file"`
      local size=`du -sm "$file" 2>/dev/null | awk '{print $1}'`

      # Min boyuttan büyük olanları diziye ekle
      if [ -n "$size" ] && [ $size -ge $min_size ]; then
        local full_path="${base_path%/}/$sub_directory"
        directories+=("$full_path:$size")  # Dizini diziye ekle: "dizin:boyut" formatında
      fi
    fi
  done

  # Dizileri boyuta göre sırala
  IFS=$'\n' sorted_directories=(`sort -t ':' -k 2nr <<<"${directories[*]}"`)

  # Sıralanmış dizinleri ekrana yazdır
  for entry in "${sorted_directories[@]}"; do
    local full_path=`cut -d ':' -f 1 <<<"$entry"`
    local size=`cut -d ':' -f 2 <<<"$entry"`
    echo "Dizin: $full_path, Boyut: ${size}MB"

    if [ $depth -gt 1 ]; then
      traverse_folders "$full_path" $((depth - 1)) $min_size "$full_path"
    fi
  done
}

echo "[Aramak istediğiniz dizini girin] (istege bagli): "
read start_directory

if [ -z "$start_directory" ]; then
  start_directory="$HOME"
elif [ "$start_directory" == "~" ]; then
  start_directory="$HOME"
fi

echo "[Dizinlerin derinliği]: "
read depth
if [ -z "$depth" ]; then
  depth=3
fi

echo "[Min boyut] (MB): "
read min_size
if [ -z "$min_size" ]; then
  min_size=100
fi

# Başlangıç dizini tam konumu
base_path=`get_full_path "$start_directory"`
cecho "$start_directory | $depth | $min_size | $base_path\n" "green" "bold"

# Dizinleri dolaş
traverse_folders "$start_directory" $depth $min_size "$base_path"