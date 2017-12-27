#!/bin/bash

#
# Checks if a flag is present in the arguments.
function hasflag() {
  filter=$1
  for var in "${@:2}"; do
    if [ "$var" = "$filter" ]; then
      echo 'true'
      break;
    fi
  done
}

#
# Read the value of an option.
function readopt() {
  filter=$1
  next=false
  for var in "${@:2}"; do
    if $next; then
      echo $var
      break;
    fi
    if [ "$var" = "$filter" ]; then
      next=true
    fi
  done
}

#
# Returns the first argument if not empty, the second otherwise
function or() {
  if [ -n "$1" ]; then
    echo $1
  else
    echo $2
  fi
}
