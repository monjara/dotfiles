#!/bin/sh

cd `dirname $0`
cd ..

rm ./oxi/lua/*.so
cd ./oxi/core
cargo build --release
cd ../../

for file in `ls oxi/core/target/release | grep dylib`; do
    if [[ $file =~ ^lib(.*)\.dylib$ ]]; then
        cp ./oxi/core/target/release/$file ./oxi/lua/${BASH_REMATCH[1]}.so
    fi
done

