# Shell Commands used for Exercise 1

1.  Create a new directory called missing under /tmp.

```bash
mkdir missing
```

2.  Look up the touch program. The man program is your friend.

```bash
man touch
```

3.  Use touch to create a new file called semester in missing.
    Write the following into that file, one line at a time:

```bash
#!/bin/sh
curl --head --silent https://missing.csail.mit.edu
```

The first line might be tricky to get working. It’s helpful to know that # starts a comment in Bash, and ! has a special meaning even within double-quoted (") strings. Bash treats single-quoted strings (') differently: they will do the trick in this case. See the Bash quoting manual page for more information.

```bash
echo '#!/bin/sh' > semester
echo 'curl --head --silent https://missing.csail.mit.edu' >> semester
cat semester
```

5.  Try to execute the file, i.e. type the path to the script (./semester) into your shell and press enter. Understand why it doesn’t work by consulting the output of ls (hint: look at the permission bits of the file).

```sh
./semester
ls -l
# total 8
# -rw-r--r--  1 admin  staff  61  2 Apr 19:01 semester
# no execute permission for anyone so can't execute file
```

6.  Run the command by explicitly starting the sh interpreter, and giving it the file semester as the first argument, i.e. sh semester. Why does this work, while ./semester didn’t?

```bash
sh semester
# works because we wrote `#!/bin/sh` in the `semester` file which means that this executable file should be run with the program `#!/bin/sh` which `sh` points to (try `which sh`)
```

7.  Look up the chmod program (e.g. use man chmod).

```bash
man chmod
```

8.  Use chmod to make it possible to run the command ./semester rather than having to type sh semester. How does your shell know that the file is supposed to be interpreted using sh? See this page on the shebang line for more information.

```bash
chmod +x semester
ls -la
```

9.  Use | and > to write the “last modified” date output by semester into a file called last-modified.txt in your home directory.

```bash
./semester | grep --ignore-case last-modified > last-modified.txt
cat last-modified.txt
```

10. Write a command that reads out your laptop battery’s power level or your desktop machine’s CPU temperature from /sys. Note: if you’re a macOS user, your OS doesn’t have sysfs, so you can skip this exercise.

```bash
# on macOS
```
