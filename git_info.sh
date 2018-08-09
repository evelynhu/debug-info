#!/bin/bash

# checks if branch has something pending
function parse_git_dirty() {
  git diff --quiet --ignore-submodules HEAD 2>/dev/null; [ $? -eq 1 ] && echo "*"
}

# gets the current git branch
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# get lastest commit hash
function parse_git_hash() {
  git rev-parse --short HEAD
}

GIT_BRANCH=$(parse_git_branch)$(parse_git_hash)
HASH=$(parse_git_hash)
echo export "const latestCommit = \"${GIT_BRANCH}\";" > latest_commit.js
