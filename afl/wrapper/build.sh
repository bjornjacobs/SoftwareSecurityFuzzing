afl_path = "/home/bjorn/afl" 

export CC="$afl_path/afl-gcc" 
export CXX="$afl_path/afl-g++" 
cmake ./
make
