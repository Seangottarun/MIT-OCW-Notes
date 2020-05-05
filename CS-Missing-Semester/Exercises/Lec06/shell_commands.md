# Shell Commands used for Exercise 6

1.  If you don’t have any past experience with Git, either try reading the first couple chapters of Pro Git or go through a tutorial like Learn Git Branching. As you’re working through it, relate Git commands to the data model.

2.  Clone the repository for the class website.

    a. Explore the version history by visualizing it as a graph.

    ```bash
    git log --graph --oneline --decorate
    ```

    b. Who was the last person to modify `README.md`? (Hint: use `git log` with an argument)

    ```bash
    git log -1
    ```

    c. What was the commit message associated with the last modification to the `collections:` line of `_config.yml`? (Hint: use `git blame` and `git show`)

    ```bash
    # use git blame to get commit hash and then use git show
    last_change=$(git blame -e _config.yml | rg collections:)
    commit_hash=$(echo $last_change | head -c 8)
    git show --oneline -s $commit_hash
    ```

3.  One common mistake when learning Git is to commit large files that should not be managed by Git or adding sensitive information. Try adding a file to a repository, making some commits and then deleting that file from history (you may want to look at this).

```bash
echo 'garbage' > garbage.txt
git add garbage.txt
git commit -m "Added garbage file"

echo 'more garbage' >> garbage.txt
git add garbage.txt
git commit -m "Even more garbage"

git filter-branch --force --index-filter \
 "git rm --cached --ignore-unmatch ~/Documents/Repo/garbage.txt" \
 --prune-empty --tag-name-filter cat -- --all
```

4.  Clone some repository from GitHub, and modify one of its existing files. What happens when you do `git stash`? What do you see when running `git log --all --oneline`? Run `git stash pop` to undo what you did with `git stash`. In what scenario might this be useful?

```bash
git stash -u # keep current changes and changes working directory to last state
git log --all --oneline # mentions stashed files and last commit
git stash pop
# this is useful if you have changes that you don't want to commit right now and need to change branches
```

5.  Like many command line tools, Git provides a configuration file (or dotfile) called `~/.gitconfig`. Create an alias in `~/.gitconfig` so that when you run `git graph`, you get the output of `git log --all --graph --decorate --oneline`.

```bash
git config --global alias.graph "log --all --graph --decorate --oneline"
```

6.  You can define global ignore patterns in `~/.gitignore_global` after running `git config --global core.excludesfile ~/.gitignore_global`. Do this, and set up your global gitignore file to ignore OS-specific or editor-specific temporary files, like `.DS_Store`.

```bash
touch ~/.gitignore_global
echo .DS_Store >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
```

7.  Clone the repository for the class website, find a typo or some other improvement you can make, and submit a pull request on GitHub.
