#!/bin/dash

######################################################################
# Test Script No. 0
# Subset 0 
# 
# Testing commands:
# - tigger-init 
# - tigger-add 
#
# Usage: test00.sh <path to tigger-init> <path to tigger-add>
######################################################################

######################################################################
# Create output file for implemented tigger commands
######################################################################

mkdir temp && cd temp 

### TEST BEGIN ###

../"$1" 2>&1 >> ../a 

### TEST END ###

cd .. && rm -rf temp 

######################################################################
# Create output file for 2041 tigger commands
######################################################################

mkdir temp && cd temp 

### VALIDATION BEGIN ###

2041 tigger-init 2>&1 >> ../b

### VALIDATION END ###

cd .. && rm -rf temp 

######################################################################
# OUtcome
######################################################################

if [ -z "$(diff a b)" ]
then 
    echo "PASSED"
else
    echo "FAILED"
    diff a b
fi

rm a b 
