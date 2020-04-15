#!bin/bash
touch start.txt
touch end.txt
touch boot_times.txt

# first store the timestamp at beginning of the boot
echo "logging start times"
log show | grep -m10 '=== system boot:' |
sed -E 's/^[0-9]*-[0-9]*-[0-9]* ([0-9]*:[0-9]*:[0-9]*).*$/\1/' |
column -t -s ':' |
awk '{ $4 = $1*60*60 + $2*60 + $3 } {print $4}' > start.txt

echo "logging end times"
# then store the timestamp at the end of the boot
log show | grep -m10 'Previous shutdown cause: 5' |
sed -E 's/^[0-9]*-[0-9]*-[0-9]* ([0-9]*:[0-9]*:[0-9]*).*$/\1/' |
column -t -s ':' |
awk '{ $4 = $1*60*60 + $2*60 + $3 } {print $4}' > end.txt

# calc boot time as the difference of the two columns
paste start.txt end.txt |
awk '{ $3 = $2 - $1 } {print $3}' > boot_times.txt

cat boot_times.txt | sort 
