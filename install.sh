echo "Update apt-get"
echo "--------------------------------------------"
apt-get -y update
echo "--------------------------------------------"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' make|grep "install ok installed")
echo Checking for make: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo "Make isn't installed. Setting up make."
  sudo apt-get -y install make
echo "--------------------------------------------"

fi
if which node > /dev/null
    then
        echo "Node is already installed, skipping..."
    else
        curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
        sudo apt-get install -y nodejs
fi
cd src && npm i -g pm2
cd src && npm i
wget -O Exif.tar.gz https://exiftool.org/Image-ExifTool-12.63.tar.gz
tar xvf Exif.tar.gz
cd Exif
perl Makefile.PL
make
make test
make install
echo "Finished installing dependencies!, Dont Break Things. Also To Run Goto index.js"
