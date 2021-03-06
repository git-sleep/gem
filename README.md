# git sleep

[![Build Status](https://travis-ci.org/maxjacobson/git-sleep-gem.svg?branch=master)](https://travis-ci.org/maxjacobson/git-sleep-gem)
[![Gem Version](https://badge.fury.io/rb/git-sleep.svg)](http://badge.fury.io/rb/git-sleep)
[![Code Climate](https://codeclimate.com/github/maxjacobson/git-sleep-gem/badges/gpa.svg)](https://codeclimate.com/github/maxjacobson/git-sleep-gem)
[![Test Coverage](https://codeclimate.com/github/maxjacobson/git-sleep-gem/badges/coverage.svg)](https://codeclimate.com/github/maxjacobson/git-sleep-gem)

(code climate score is higher than it should be, I think, because it's ignoring
the non `*.rb` files)

## installation:

`gem install git-sleep`

to be used in conjunction with [gitsleep.com](http://www.gitsleep.com)

## usage:

`git sleep authorize` will walk you through authorizing with Jawbone

`git sleep init` (from within a git repo) will install two git hooks:

* a git pre-commit hook that can prevent commits if you haven't slept enough
* a git post-commit hook which will annotate your successful commits with sleep data

