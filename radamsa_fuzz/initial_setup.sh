cd fuzz/wrapper
chmod +x main
cd ../..
cd fuzz
chmod +x run.sh
mkdir fuzz
mkdir hangs
mkdir crashes
cd ..
cd radamsa
sudo make install
cd ..

