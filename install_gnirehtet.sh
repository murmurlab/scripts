
#install adb tools

curl -o ~/Downloads/adb-tools.zip https://dl.google.com/android/repository/platform-tools-latest-darwin.zip -L
unzip ~/Downloads/adb-tools -d ~/Downloads/
rm -fr ~/Downloads/adb-tools.zip

#add to path

echo 'export PATH=$PATH:~/Downloads/platform-tools' >> ~/.zshrc
export PATH=$PATH:~/Downlaods/platform-tools

:'

#install brew

mkdir -p ~/goinfre/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ~/goinfre/homebrew
echo 'export PATH=$PATH:~/goinfre/homebrew/bin:~/Downloads/platform-tools' >> ~/.zshrc
export PATH=$PATH:~/goinfre/homebrew/bin:~/Downlaods/platform-tools

#install java via brew
#this may take some time

brew update
brew install openjdk
echo 'export PATH="/goinfre/ahbasara/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc

'

#install java directly

curl -o ~/Downloads/jre-8u331-macosx-x64.tar.gz https://javadl.oracle.com/webapps/download/GetFile/1.8.0_331-b09/165374ff4ea84ef0bbd821706e29b123/unix-i586/jre-8u331-macosx-x64.tar.gz -L
tar -zxvf ~/Downloads/jre-8u331-macosx-x64.tar.gz -C ~/Downloads
#tar -zxvf ~/Downloads/jre-8u331-macosx-x64.tar.gz -C /goinfre/$USER
rm -fr ~/Downloads/jre-8u331-macosx-x64.tar.gz

#add to path

echo 'export JAVA_HOME=~/Downloads/jre1.8.0_331.jre/Contents/Home/' >> ~/.zshrc
export JAVA_HOME=~/Downloads/jre1.8.0_331.jre/Contents/Home/

#install gnirehtet

curl -o ~/Downloads/gnirehtet-java-v2.5.zip https://github.com/Genymobile/gnirehtet/releases/download/v2.5/gnirehtet-java-v2.5.zip -L
unzip ~/Downloads/gnirehtet-java-v2.5.zip -d ~/Downloads
adb kill-server
java -jar ~/Downloads/gnirehtet-java/gnirehtet.jar install
