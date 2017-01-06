#!/bin/sh

COUNTER=0

for content in $(ls | sort -n); do
  C=$(printf "%02d" $COUNTER)
  D=$C.$content; COUNTER=$((COUNTER + 1)) mv $content $D
done
