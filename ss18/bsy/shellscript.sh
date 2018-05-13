#!/bin/sh
# This isch a comment!
echo "I was called with $# parameters"
echo "My name is $0"
echo "My first paramter is $1"
echo "My second parameter is $2"
echo "All my params are "$@""
echo "My internal ID is $$"
echo "Exitcode last prog is $?"
