set -e
export PREFIX="/opt/cross"
export TARGET="i686-elf"
export PATH="$PREFIX/bin:$PATH"

jobs=7

binutils_dir="binutils-2.46.0"
binutils_build="binutils_build"

gdb_dir="gdb-17.2"
gdb_build="gdb_build"

gcc_dir="gcc-15.3.0"
gcc_build="gcc_build"

# build binutils
if [ ! -d $binutils_build ]; then
	mkdir $binutils_build
fi
cd $binutils_build
../$binutils_dir/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror 
make -j$jobs
make install
cd ..

# build gdb
if [ ! -d $gdb_build ]; then
	mkdir $gdb_build
fi
cd $gdb_build
../$gdb_dir/configure --target=$TARGET --prefix="$PREFIX" --disable-werror
make -j$jobs all-gdb
make install-gdb
cd ..

# build gcc
which -- $TARGET-as || echo "Error: $TARGET-as is not in the PATH" >&2 && exit 1

if [ ! -d $gcc_build ]; then
	mkdir $gcc_build
fi
cd $gcc_build
mkdir build-gcc
cd build-gcc
../$gcc_dir/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers --disable-hosted-libstdcxx
make -j$jobs all-gcc
make -j$jobs all-target-libgcc
make -j$jobs all-target-libstdc++-v3
make install-gcc
make install-target-libgcc
make install-target-libstdc++-v3

