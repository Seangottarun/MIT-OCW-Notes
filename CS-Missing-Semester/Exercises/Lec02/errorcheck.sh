#!/bin/bash
touch outputstream.txt
touch errorstream.txt

run=0

while true; do
    # captures standard output and error streams to files
    run=$((run + 1))

    ./errorscript.sh >> outputstream.txt 2> errorstream.txt

    if [[ $? -eq 1 ]]; then
        echo "Finally got a bad run"
        break
    fi
done

echo "Now printing both of standard output and error streams"
cat outputstream.txt
cat errorstream.txt

echo "It took $run runs for this script to fail"
