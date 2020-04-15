#!/bin/bash
touch occurring.txt
touch alphabet.txt
cat /usr/share/dict/words | sed -E 's/^[B-Zb-z]*[Aa]?[B-Zb-z]*[Aa]?[B-Zb-z]*$//' | sed -E 's/^.*s$//' | sed '/^$/d' | sed -E 's/^.*([a-z][a-z])$/\1/' | sort | uniq > occurring.txt

for x in {a..z}
do
    for y in {a..z}
    do
        echo "$x$y" >> alphabet.txt
    done
done

diff occurring.txt alphabet.txt | sed -E 's/^.*([a-z][a-z])$/\1/' | sed -E 's/^.*[^(a-z)]$//' | sed '/^$/d' > not_occurring.txt
