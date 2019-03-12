

# .bashrcd

Some alias to simplify working with .bashrc

## Features

* Adds directory sourcing, to logically separate bashrc entries
* Aliases to add, list, or remove bashrc entries
* Control load priority of bashrc entries
* Simple install for new servers from github.


## Future

Some items that will be nice to add in future:

* Sync profile from git based on enable flag
* Include git config as part of install command


## Install

This created entries in .bashrcd and copies 3 default aliases for creating, removing, and listing bashrc entries.


```
curl -s https://raw.githubusercontent.com/targaryen/bashrcd/master/install/install_brcd.sh | bash  

```

## Remove

This only removes entry from .bashrc, .bashrcd still exists.

```
curl -s https://raw.githubusercontent.com/targaryen/bashrcd/master/install/remove_brcd.sh | bash
```

