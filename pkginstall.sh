
CHP="$1"
PKG="$2"

cat packages.csv | grep -i "^$PKG" | grep -i -v "/.patch;" | while read line; do
    # NAME="`echo $line | cut -d\; -f1`"
    VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
    MD5SUM="`echo $line | cut -d\; -f4`"
    CACHEFILE="$(basename "$URL")"
    DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')"

    echo "Extracting $CACHEFILE"
    tar -xf "$CACHEFILE" -C "$DIRNAME"

    pushd "$DIRNAME"

        if ["$(ls -1A | wc -l)" == "1"]; then
            mv $(ls -1A)/* ./
        fi 

        echo "Compiling $PKG"
        sleep 5
        mkdir -pv "../logs/step$CHP/"
        if ! source "../step$CHP/$PKG.sh" 2>&1| tee "../logs/step$CHP/$PKG.log"; then
            echo "Compiling $PKG FAILED!"
            popd
            exit 1
        fi
        echo "Done Compiling $PKG"

    popd
done