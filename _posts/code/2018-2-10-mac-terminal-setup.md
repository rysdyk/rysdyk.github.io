---
layout: post
title:  "Mac Terminal Setup"
date:   2018-2-10 06:00:00 -0600
categories: [mac, git, rails]
blog: code
tag: code
---

Here are a few quick things to make working in Mac's Terminal with Rails and Git a little better:
1. [Aliases](#aliases)
2. [Quick Jump Between Folders](#quick-jump)
3. [Display Current Git Branch](#display-git-branch)
4. [Add Git Branch Completion](#git-tab-completion)

Some of these things involve downloading some stuff and then updating the .bash\_profile or .bashrc. To open those, in terminal type: `open ~/.bashrc` or `open ~/.bash_profile`

## Aliases

Aliases are shortcuts for things commonly typed into terminal: instead of `rails console`, just use `rc` and instead of `git push origin master`, just `gpom`. It's nice to avoid typing the same things over and over again, especially if it's easy to make a typo.

`gdm` and `olm` are two of my particular favorites.

No Homebrew needed here. Just setup aliases like these in .bashrc:

{% highlight text %}
alias m="mate ."
alias o="open ."
alias s="sublime ."
alias a="atom ."

  # git aliases
alias gl="git pull"
alias gc="git checkout"
alias gp="git push"
alias gpom="git push origin master"
alias gb="git branch"
alias gs="git status"
alias gaa="git add ."
alias gr="git rebase"
alias grc="git rebase --continue"
alias gri="git rebase -i"
alias gcm="git commit -m"
alias gd="git diff"
 # open all files with git conflicts in textmate
alias gdm="git diff --name-only | uniq | xargs mate"
alias glg="git log"


  # rails related aliases
alias rc="rails console"
alias rs="rails server"
alias rdbm="rake db:migrate"
alias rdbs="rake db:seed"
alias renvt="RAILS_ENV=test"
alias rt="rake test"
alias be="bundle exec"
alias bi="bundle install"
alias bu="bundle update"
 # open last migration in textmate
alias olm="ls db/migrate/* | tail -n1 | xargs mate"

alias js="jekyll serve"
{% endhighlight %}

Ensure .bashrc is referenced in .bash\_profile. At or near the top of .bash\_profile include this line: `source ~/.bashrc  # get my Bash aliases`. Also, .bashrc is really picky about formatting, the alias needs to touch the equals sign which needs to touch the opening double quote.

Once this is updated, start a new terminal session or use `source ~/.bash_profile` in the current session to make the new aliases available.

## Quick Jump

Quick jump between folders is a game-changer. From within one app, navigate directly to another non-linear folder or even another app without changing directory up and down multiple levels!

First, use [Homebrew](https://brew.sh) to install bash completion: `brew install bash-completion`

Add the following code to .bash\_profile:

{% highlight text %}
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi
{% endhighlight %}

And then in .bashrc:

{% highlight text %}
PROJ_DIR="~/Work"
ORDERED_SUBFOLDERS="app1 app2 app3 app4 app5"

CDPATH=".:~:$PROJ_DIR"
for FOLDER in $ORDERED_SUBFOLDERS; do
  CDPATH="$CDPATH:$PROJ_DIR/$FOLDER"
done
{% endhighlight %}

In this example, PROJ\_DIR will be the main folder (it could be anything). Then specify the subfolders, whatever those are. Restart terminal, and cd between app projects without navigating up and down directories one at a time. Folders within the sub folders will be available to quick jump to as well.

## Display Git Branch

It's nice to see which branch we're working on. To display the current git branch in terminal, place this code in .bash\_profile:

{% highlight text %}
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
{% endhighlight %}

## Git Tab Completion

Just like terminal will try to auto-compelete folder and file names with tab, we can add the same thing for git branch names. Just type the first few letters of a branch name and tab to complete it!

Install git-completion via curl command: `curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash`

Then add the following to .bashrc:

{% highlight text %}
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash

  # Add git completion to aliases
  __git_complete gc _git_checkout
  __git_complete gl _git_pull
  __git_complete gp _git_push
  __git_complete gb _git_branch
fi
{% endhighlight %}

Restart terminal or re-source the .bash\_profile. Not only does this work with regular typed out git commands, but it will work with aliases as well.
