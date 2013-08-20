### TODOS

* use their name they gave jawbone, not their env[username]
* maybe use their ssh public key to identify them, not their jawbone xid? at any rate needs some layer of security. that could be it. actually, wait, that doesn't make sense.

# git sleep

`gem install git-sleep`

to be used in conjunction with [gitsleep.com](http://www.gitsleep.com)

## usage:

`git sleep authorize` will walk you through authorizing with Jawbone

`git sleep init` (from within a git repo) will install a git pre-commit hook for you

now when you try to commit to this repo, it will check if you really *should* be committing to this repo
