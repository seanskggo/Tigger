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

    mkdir temp && cd temp || exit

    tigger-init # should succeed
    tigger-init # should error => .tigger already exists
    tigger-init asdf # should error => .tigger already exists > usage error
    rm -rf .tigger 
    tigger-init asdf # should error => usage error

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    mkdir temp && cd temp || exit

    2041 tigger-init 
    2041 tigger-init 
    2041 tigger-init asdf 
    rm -rf .tigger 
    2041 tigger-init asdf 

    cd .. && rm -rf temp

}

######################################################################
# Outcome
######################################################################

test_commands > a 2>&1
make_answers > b 2>&1

if [ -z "$(diff a b)" ]
then 
    echo "PASSED"
else
    echo "FAILED"
    diff a b 
fi

rm a b
