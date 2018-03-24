---
layout: post
title: "How to Use Git Rebase"
date: 2018-3-24 06:00:00 -0600
categories: [git]
blog: code
tag: code
---

When starting out with git, rebase is scary because it's often not explained well, but it's really not that hard. It's important to understand rebase because it should be a regular tool used with git.

There are few different ways to use rebase, but here's the basic concept of git rebase: **to keep your branch up-to-date with its parent branch**.

For example, feature branch B is created off of master branch A:
```
Master A:  [1] - - - [2]
                                    \  
                                       \
Feature B:                       [3]
```
Here, feature B is *based on* master A at commit 2. The point where they split, Commit 2, is B's base. To 'rebase' is to update/move where this split happens. 


While working on feature B, you checkout master and pull from origin master to find other developers have committed new code to master A. The situation now looks something like:
```
Master A:  [1] - - - [2] - - - [4] - - - [5] - - - [6]
                                   \  
                                      \
Feature B:                     [3] - - - [7]    
```

Without rebase, when B is merged back into A there can be a ton of conflicts since many things have changed on A as B was being worked. Fixing all these conflicts all at once at the time of merge can be tedious and error-prone.

Moreover, it's a good idea to make sure your feature branch is still relevant to master as you're working on it.

What if a developer could incorporate the changes of Master A into Feature B on a regular basis as B is being worked on? This is rebase!

While on branch B, type: 'git rebase A'. This is rebasing B *onto* A. This moves B's base from 2 to 6, thus incorporating commits 4, 5 and 6 into B.
```
Master A:  [1] - - - [2] - - - [4] - - - [5] - - - [6]
                                                                        \  
                                                                           \
Feature B:                                                          [3] - - - [7]             
```
Now feature B is all caught up. (Any code conflicts can be handled now and how to do this will be the subject of a future post).

The nice thing about rebase is that it can be used as often as needed. If you know master has been updated, pull the changes and rebase. Or simply get in the daily habit of using rebase every morning.

A morning routine might look like:
```
git checkout master
git pull origin master
git checkout feature_branch
git rebase master
```

The terminology of 'off of', 'onto' and 'into' can get confusing, but it goes like this: rebasing B *onto* A brings the new part(s) of A *into* B.

It's important to note that rebasing can get a little tricky when working with remote branches. After rebasing feature B onto master A, a force push may be required if feature B has a remote git repository. The golden rule of force pushing is never force push to a public repo: if anybody else is sharing feature B, avoid force pushing. In general, don't use force push unless you're fairly sure about what you're doing.

This is the basic concept of git rebase!