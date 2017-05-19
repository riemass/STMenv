# libusb
cd ~/gitstuff
git clone https://github.com/texane/stlink.git
cd stlink

mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=~/armtools -DCMAKE_BUILD_TYPE=Release ..
make
sudo make install

source ~/armtools/arm_setup.sh

sudo ldconfig 

sudo udevadm control --reload-rules
sudo udevadm trigger

sudo groupadd stlink
sudo usermod -aG stlink $USER
