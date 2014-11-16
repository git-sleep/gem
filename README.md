# git sleep

[![Build
Status](https://travis-ci.org/maxjacobson/git-sleep-gem.svg?branch=add-travis)](https://travis-ci.org/maxjacobson/git-sleep-gem)

`gem install git-sleep`

to be used in conjunction with [gitsleep.com](http://www.gitsleep.com)

## usage:

`git sleep authorize` will walk you through authorizing with Jawbone

`git sleep init` (from within a git repo) will install two git hooks:

* a git pre-commit hook that can prevent commits if you haven't slept enough
* a git post-commit hook which will annotate your successful commits with sleep data

