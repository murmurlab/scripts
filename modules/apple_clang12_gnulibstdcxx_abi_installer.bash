# TMPDIR=/tmp/
shell_f=~/.bash_profile
_LOCAL=~/.local/share/

mkdir -p "$_LOCAL"
unzip -o -d "$_LOCAL/gcc@9" "$1"
# 
# 

# exit 1

libstdcxx_dir="$_LOCAL/gcc@9/9.5.0"

inc_dir="$libstdcxx_dir/include/c++/9.5.0"
platform_inc_dir="$inc_dir/x86_64-apple-darwin19/"

lib_dir="$libstdcxx_dir/lib/gcc/9"


lines="stdcxx_cxxflags='-stdlib++-isystem $inc_dir'
stdcxx_cxxflags+=' -stdlib++-isystem $platform_inc_dir'
stdcxx_lxxflags='-Wno-deprecated -stdlib=libstdc++ -L $lib_dir'
export stdcxx_cxxflags stdcxx_lxxflags"
echo -n
echo -n

echo "$lines"
echo -n
echo -n
echo -n

if ! grep -qF "$lines" "$shell_f"; then
    echo -e "\n\n$lines" >> "$shell_f"
else
    echo "lines already exists." $shell_f
fi


