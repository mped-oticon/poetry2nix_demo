# Simple how-to for poetry2nix

This is also explained on https://www.tweag.io/blog/2020-08-12-poetry2nix/

See also https://github.com/nix-community/poetry2nix



# Why?
This was good exercise in learning how to use poetry2nix.
This can serve as an introduction/stencil for other projects.

# How?
poetry is Nix-agnostic, but poetry is much more reproducible than pip.
This makes poetry very attractive from Nix's perspective; to the point
where a Nix expression can be written (poetry2nix) which reads in
poetry-related files, and can generate Nix derivations from these.
With such Nix derivations: 
 1. We natively fetch from PyPI - same repo pip uses.
 2. We natively install to /nix/store - like any native Nix package.
    And thus enjoy nix's benefits; shared sparse install, gc, etc.
 3. We avoid shellHook always running venv+pip.
 4. We avoid placing venv in some humanly-decided rando location.


# Example 1: Update the lockfile

```
eisbaw@t460s:~/topics/poetry_nix_demo2$ time nix-shell --pure --run "exit 0"
Yay poetry.lock exists. I'll honor it
You have a perfectly usable environment now :)

real	0m1.435s
user	0m1.234s
sys	0m0.200s
eisbaw@t460s:~/topics/poetry_nix_demo2$ rm poetry.lock 
eisbaw@t460s:~/topics/poetry_nix_demo2$ time nix-shell --pure --run "exit 0"
Boo! You don't have a lock file - so I'll make it now
Updating dependencies
Resolving dependencies... (0.2s)

Writing lock file
Lockfile created. But this nix-shell is unusable; start it again. Exiting for now.

real	0m2.451s
user	0m2.221s
sys	0m0.165s
eisbaw@t460s:~/topics/poetry_nix_demo2$ time nix-shell --pure --run "exit 0"
Yay poetry.lock exists. I'll honor it
You have a perfectly usable environment now :)

real	0m1.425s
user	0m1.191s
sys	0m0.234s
eisbaw@t460s:~/topics/poetry_nix_demo2$ ls poetry.lock 
poetry.lock

```


# Example 2: Usage

`$PYTHONPATH` should be updated thanks to poetry2nix, so the dependencies specified in the `poetry.lock` (and thus `pyproject.toml`) should be present:

```
nix-shell --pure --run "python3 -c 'import imgapp; print(imgapp)'"
```
