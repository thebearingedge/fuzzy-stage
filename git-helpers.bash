#!/usr/bin/env bash

# set pipe fail to true
set -o pipefail

# pipe git status to fzf and git add the result to the index
function fuzzy-stage {
  git status -s | fzf | awk '{print $2}' | xargs git add
}

# pick a modified file with fzf and view the git diff
function fuzzy-diff {
  git status -s | fzf | awk '{print $2}' | xargs git diff
}

# pick a file with fzf and compare it with another branch
function fuzzy-compare {
	local file
	local branch
	file=$(fzf)
	branch=$(git branch | fzf | awk '{print $1}')
	git diff "$branch" "$file"
}

# git status pipe to fzf and restore the selected file with confirm prompt
function fuzzy-restore {
	local file
	file=$(git status -s | fzf | awk '{print $2}')
	read -p "Are you sure you want to loss your changes for $file? [y/n] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		git checkout $file
	fi
}

# make aliases for all fuzzy git functions
alias ga='fuzzy-stage'
alias gd='fuzzy-diff'
alias gc='fuzzy-compare'
alias gr='fuzzy-restore'
