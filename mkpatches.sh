#!/bin/bash

a="$1/net/minecraft/server"
b="$2/net/minecraft/server"

for file in $(printf "$(/bin/ls $a)\n$(/bin/ls $b)" | sort | uniq)
do
    echo "Diffing $file"
    if [ -f "$a/$file" ]
    then 
        sed -i 's/\r//' "$a/$file"
    fi
    if [ -f "$b/$file" ]
    then
        sed -i 's/\r//' "$b/$file"
    fi
    outName=$(echo $3/"$(echo $file | cut -d. -f1)".patch)
    patchNew=$(diff -uN --label a/net/minecraft/server/$file "$a/$file" --label b/net/minecraft/server/$file "$b/$file")
    rm -f "$outName"
    if [ "$patchNew" ]
    then
        echo "$patchNew" > "$outName"
    fi
done
