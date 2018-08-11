---
layout: post
title: "How to use Git Rebase, Part II: Git Rebase Interactive"
date: 2018-08-11 05:00:00 -0500
categories: [git]
blog: code
tag: code
---

I have previously covered Git rebase, [Part I](/2018/03/24/how-to-use-git-rebase.html), but here's another way to use it: combine commits on your branch into fewer or just one commit.

This is a nice way to clean up git history. Frequently adding & committing is a good habit, but a ton of commits can really muck up a git history. Git rebase will help clean that up.

Type `git log` to see how far ahead feature branch B is from master branch A. Let's say branch B has 5 commits ahead of ahead of A. By using `git rebase -i HEAD~5` these 5 commits can be combined.

Normally, this will open up vim. However, I've added a command to .gitconfig to open this up in my text editor (Sublime Text, in this case), making it really easy to edit. Type this into command: `git config --global core.editor "sublime -w"`

Or, open up .gitconfig and add something like the following under [core]

```
[core]
  editor = sublime -w
```

The command is `git rebase -i HEAD~5`, and -i stands for interactive mode. After submitting this, sublime text will open a file showing something like:

```
pick 38c1680 get bye weeks working
pick 349f80d add adp files and other updates
pick cf8bd0e fix json syntax typo
pick c7e6306 adjust styles
pick 1155626 update rankings

# Rebase e778bd6..1155626 onto e778bd6 (5 commands)
#
# Commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squ

```

To combine these five commits, replace pick with squash like so:

```
pick 38c1680 get bye weeks working
squash 349f80d add adp files and other updates
squash cf8bd0e fix json syntax typo
squash c7e6306 adjust styles
squash 1155626 update rankings

```

After doing this, just save and close. Then, another window should open up in Sublime Text showing commit information. Go ahead and just close that.

At this point, these 5 commits have been combined into a single commit. The commit messages from the 4 squashed commits will still be available in the commit comment.

One last thing, combining commits has re-written git history. Which means it will require a force push to your remote branch: `git push -f origin branch-b`



