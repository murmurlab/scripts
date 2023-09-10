function cleanup {
  pkill sleepwipe
}

trap cleanup EXIT

sleepwipe -d &
tput setaf 10
while :
do
  for (( i=0 ; i<=363 ; i++ ));
  do
    printf "$(($RANDOM%2))"
  done
  sleep 0.001
done