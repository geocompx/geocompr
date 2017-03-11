#!/bin/bash
set -o errexit -o nounset
BASE_REPO=$PWD

update_website() {
  cd ..; mkdir gh-pages; cd gh-pages
  git init
  git config user.name "" #missing name
  git config user.email "" #missing email
  git config --global push.default simple
  git remote add upstream "https://$GH_TOKEN@github.com/Robinlovelace/rgeobook.git"
  git fetch upstream 2>err.txt
  git checkout gh-pages
  
  cp -fvr $BASE_REPO/_book/* .
  git add *.html; git add libs/; git add figures/; git add style.css; git add images/;
  git add _main_files/*; git add *.json; git add main.md
  git commit -a -m "Updating book (${TRAVIS_BUILD_NUMBER})"
  git status
  git push 2>err.txt
  cd ..
}

update_website