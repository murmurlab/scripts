
#install adb tools

curl -o ~/Downloads/adb-tools.zip https://dl.google.com/android/repository/platform-tools-latest-darwin.zip -L
unzip ~/Downloads/adb-tools -d ~/Downlaods/

#install brew

mkdir -p ~/goinfre/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/goinfre/homebrew
echo 'export PATH=$PATH:~/goinfre/homebrew/bin:~/Downloads/platform-tools' >> ~/.zshrc
export PATH=$PATH:~/goinfre/homebrew/bin:~/Downlaods/platform-tools

#install java via brew
#this may take some time

brew update
brew install openjdk
echo 'export PATH="/goinfre/ahbasara/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc

#install gnirehtet

curl -o ~/Downloads/gnirehtet-java-v2.5.zip https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-java-v2.5.zip -L
unzip ~/Downloads/gnirehtet-java-v2.5.zip -d ~/Downloads
ja
adb kill-server
java -jar ~/Downloads/gnirehtet-java/gnirehtet.jar install
