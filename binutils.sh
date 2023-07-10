mkdir -v build
cd build

../configure --prefix=$BUMIN/tools \
--with-sysroot=$BUMIN \
--target=$BUMIN_TGT \
--disable-nls \
--disable-werror \
&& make \
&& make install