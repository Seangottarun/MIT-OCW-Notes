# Shell Commands used for Exercise 7

1. Most makefiles provide a target called `clean`. This isn’t intended to produce a file called `clean`, but instead to clean up any files that can be re-built by make. Think of it as a way to “undo” all of the build steps. Implement a `clean` target for the `paper.pdf` Makefile above. You will have to make the target phony. You may find the git ls-files subcommand useful. A number of other very common make targets are listed here.

```makefile
clean:
  rm paper.aux paper.fdb_latexmk paper.fls paper.log paper.out paper.synctex.gz paper.toc paper.xdv
```

2. Take a look at the various ways to specify version requirements for dependencies in Rust’s build system. Most package repositories support similar syntax. For each one (caret, tilde, wildcard, comparison, and multiple), try to come up with a use-case in which that particular kind of requirement makes sense.

```makefile
# caret
# an update is allowed as long as it doesn't modify the left-most nonzero digit
# Useful if you want to have at least a certain minor version without
# updating to the next major version (which has breaking changes)
^1.2.3  :=  >=1.2.3, <2.0.0
^1.2    :=  >=1.2.0, <2.0.0
^1      :=  >=1.0.0, <2.0.0
^0.2.3  :=  >=0.2.3, <0.3.0
^0.2    :=  >=0.2.0, <0.3.0
^0.0.3  :=  >=0.0.3, <0.0.4
^0.0    :=  >=0.0.0, <0.1.0
^0      :=  >=0.0.0, <1.0.0


# tilde
# An update is allowed for the last specified digit (major, minor, patch) and
# all smaller updates (minor or patch)
# Useful if you don't want to install too many updates (stricter control than caret)
~1.2.3  := >=1.2.3, <1.3.0
~1.2    := >=1.2.0, <1.3.0
~1      := >=1.0.0, <2.0.0


# wildcard
# Can update to any version that fits wildcard pattern
# Useful if you don't really care too much about the updates since you have a
# really low dependency (ex. you rely on version X.0.0)
*     := >=0.0.0
1.*   := >=1.0.0, <2.0.0
1.2.* := >=1.2.0, <1.3.0


# comparison
# Manually specify a range
# Useful to quickly specify a minimum version or maximum major version
>= 1.2.0
> 1
< 2
= 1.2.3

# multiple
# Useful for supporting older code where you need old code that's not too old
# or too new
>= 1.2, < 1.5
```

3. Git can act as a simple CI system all by itself. In `.git/hooks` inside any git repository, you will find (currently inactive) files that are run as scripts when a particular action happens. Write a `pre-commit` hook that runs `make paper.pdf` and refuses the commit if the `make` command fails. This should prevent any commit from having an unbuildable version of the paper.

```bash
# see pre-commit file
```

4. Set up a simple auto-published page using `GitHub Pages`. Add a `GitHub Action` to the repository to run `shellcheck` on any shell files in that repository (here is one way to do it). Check that it works!

5. Build your own GitHub action to run `proselint` or `write-good` on all the `.md` files in the repository. Enable it in your repository, and check that it works by filing a pull request with a typo in it.
