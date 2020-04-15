# Shell Commands used for Exercise 4

1.  Take this short interactive regex tutorial.

2.  Find the number of words (in `/usr/share/dict/words`) that contain at least three `a`'s and don’t have a '`s` ending. What are the three most common last two letters of those words? `sed`’s `y` command, or the `tr` program, may help you with case insensitivity. How many of those two-letter combinations are there? And for a challenge: which combinations do not occur?

Number of words that contain at least three `a`'s and don’t have a '`s` ending

```bash
cat /usr/share/dict/words | wc -l
# Answer: 235886
# replace all words with 0-2 a's with an empty line
# replace all words with an s ending with an empty line
# then delete empty lines with sed
cat /usr/share/dict/words | sed -E 's/^[B-Zb-z]*[Aa]?[B-Zb-z]*[Aa]?[B-Zb-z]*$//' | sed -E 's/^.*s$//' | sed '/^$/d' | wc -l
# Answer: 7148
```

The three most common last two letters of those words

```bash
# replace entire string with last 2 characters
cat /usr/share/dict/words | sed -E 's/^[B-Zb-z]*[Aa]?[B-Zb-z]*[Aa]?[B-Zb-z]*$//' | sed -E 's/^.*s$//' | sed '/^$/d' | sed -E 's/^.*([a-z][a-z])$/\1/' | sort | uniq -c | sort -nk1,1 | tail -n3
# Answer:  
# 763 an
# 814 ia
# 1039 al
```

How many two-letter combinations are there

```bash
cat /usr/share/dict/words | sed -E 's/^[B-Zb-z]*[Aa]?[B-Zb-z]*[Aa]?[B-Zb-z]*$//' | sed -E 's/^.*s$//' | sed '/^$/d' | sed -E 's/^.*([a-z][a-z])$/\1/' | sort | uniq -c | wc -l
# Answer: 144
```

Which combinations do not occur

```bash
source other_combos.sh
cat not_occurring.txt
```

3.  To do in-place substitution it is quite tempting to do something like `sed s/REGEX/SUBSTITUTION/ input.txt > input.txt`. However this is a bad idea, why? Is this particular to sed? Use `man sed` to find out how to accomplish this.

```bash
# This is not recommended because editing the file in-place without backup risks corruption or partial content when disk space is low
# instead, use the -i flag from below
```

```bash
man sed
# -i extension
#   Edit files in-place, saving backups with the specified extension.  If a zero-length extension is given, no backup will be saved.  It is not recommended to give a zero-
#   length extension when in-place editing files, as you risk corruption or partial content in situations where disk space is exhausted, etc.
```

4.  Find your average, median, and max system boot time over the last ten boots. Use `journalctl` on Linux and `log show` on macOS, and look for log timestamps near the beginning and end of each boot. On macOS, [look for](https://eclecticlight.co/2018/03/21/macos-unified-log-3-finding-your-way/):

```
=== system boot:
```

and

```
Previous shutdown cause: 5
```

```bash
source boot_times.sh
```

5.  Look for boot messages that are not shared between your past three reboots (see `journalctl`’s `-b` flag). Break this task down into multiple steps. First, find a way to get just the logs from the past three boots. There may be an applicable flag on the tool you use to extract the boot logs, or you can use `sed '0,/STRING/d'` to remove all lines previous to one that matches `STRING`. Next, remove any parts of the line that always varies (like the timestamp). Then, de-duplicate the input lines and keep a count of each one (`uniq` is your friend). And finally, eliminate any line whose count is 3 (since it was shared among all the boots).

6.  Find an online data set like [this one](https://stats.wikimedia.org/EN/TablesWikipediaZZ.htm), [this one](https://ucr.fbi.gov/crime-in-the-u.s/2016/crime-in-the-u.s.-2016/topic-pages/tables/table-1). or maybe one [from here](https://www.springboard.com/blog/free-public-data-sets-data-science-project/). Fetch it using curl and extract out just two columns of numerical data. If you’re fetching HTML data, pup might be helpful. For JSON data, try jq. Find the min and max of one column in a single command, and the sum of the difference between the two columns in another.
