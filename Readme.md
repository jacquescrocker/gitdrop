# Git Drop

a Ruby hack for OSX that autosync a git repo every X seconds

**warning:** this is a horrible hack and shouldn't be used by anyone


## Install

- Clone to somewhere on your computer

    `git clone https://github.com/railsjedi/gitdrop.git`

- add the gitdrop/bin folder to your PATH

- cd into the folder you want to start syncing

- `gitdrop start`

    this will start watching this folder (creates and loads a launchd agent)

- `gitdrop stop`

    this will stop watching this folder (unloads and deletes the launchd agent)

