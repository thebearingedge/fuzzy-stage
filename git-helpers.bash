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

"$@"
