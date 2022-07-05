#!/bin/dash

######################################################################
# Test Script No. 0
# Subset 0 
# 
# Testing commands:
# - tigger-init 
# - tigger-add 
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp

    # tigger-init tests
    tigger-init # should succeed
    tigger-init # should error => .tigger already exists
    tigger-init asdf # should error => .tigger already exists > usage error
    rm -rf .tigger 
    tigger-init asdf # should error => usage error

    # tigger-add tests
    tigger-init
    touch a b
    tigger-add a b # should succeed
    tigger-add c # should error => non existent file
    rm -rf .tigger
    tigger-add a b # should error => no .tigger present
    tigger-add c # should error => no .tigger error > non existent file error

   cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

make_answers () {

    echo "Initialized empty tigger repository in .tigger" 
    echo "tigger-init: error: .tigger already exists" 
    echo "tigger-init: error: .tigger already exists" 
    echo "usage: tigger-init"
    echo "Initialized empty tigger repository in .tigger" 
    echo "tigger-add: error: can not open 'c'"
    echo "tigger-add: error: tigger repository directory .tigger not found"
    echo "tigger-add: error: tigger repository directory .tigger not found"

}

######################################################################
# Outcome
######################################################################

test_commands > a
make_answers > b

if [ -z "$(diff a b)" ]
then 
    echo "PASSED"
else
    echo "FAILED"
    diff a b 
fi

rm a b
