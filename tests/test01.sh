#!/bin/dash

######################################################################
# Test Script No. 1
# Subset 0 
# 
# Testing commands:
# - tigger-commit
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp

    # tigger-init tests
    tigger-commit # should error => tigger does not exist

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    echo "tigger-commit: error: tigger repository directory .tigger not found"

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
