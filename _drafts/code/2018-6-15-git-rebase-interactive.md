---
layout: post
title: "How to use Git Rebase, Part II: Git Rebase Interactive"
date: 2018-06-15 05:00:00 -0500
categories: [git]
blog: code
tag: code
---

I have previously discussed Git rebase, [Part I](/how-to-use-git-rebase), but here's anther way to use it:

The second way to use rebase is to combine commits on your branch into fewer or just one commit. This is a nice way to clean up git history. Frequently commiting is a good habit, but a ton of commits can really muck up a git history. Git rebase will help clean that up.

Type `git log` to see how far ahead branch B is from branch A. Let's say branch B has 5 commits ahead of ahead of A. By using `git rebase -i HEAD~5` these 5 commits can be combined.

Normally, this will open up vim. However, I've added a couple command to .bashrc to open this up in my text editor, making it really easy to edit.


