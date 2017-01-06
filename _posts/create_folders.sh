#!/bin/sh

for a in $(find . -name "*.html" -or -name "*.md"); do
  B=$(basename $a | sed -e "s/\..*//;")
  mkdir $B
  mv $a $B/default.md
done
