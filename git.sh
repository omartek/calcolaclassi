#!/bin/sh
git add --all
git commit -am $1
git push origin master
