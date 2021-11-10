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

#
# Return the nth first arguments
function nfirstargs() {
        num=$1
        current=0
        shift
        for var in "$@";do
                if [ $current -lt $num ]; then
                        current=$(($current + 1))
                        echo $var
                else
                        break
                fi
        done
} 

#
# Filter the specified number of options and flags
# Example:
#   filteropts 2 -version --dry-run foo bar baz
#   -> foo bar baz
function filteropts() {
        num=$1
        if echo $num | grep '[^0-9]' > /dev/null; then
                echo "$@"
        else
                skip=$(($num+2))
                tofilter=`nfirstargs $@`
                next=false
                #Loop through arguments starting from skip
                for candidate in "${@:$skip}"; do
                        if $next; then
                                next=false
                                continue;
                        fi

                        #Loop through items that need to be skiped and see if candidate is included
                        for i in $tofilter; do
                                if [ $candidate = "$i" ]; then
                                        next=true
                                        break;
                                fi
                        done
                        if ! $next; then
                                echo $candidate
                        fi
                done
        fi
}
