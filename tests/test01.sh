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
    tigger-commit # should error => .tigger does not exist
    tigger-commit asdf # should error => .tigger does not exist > usage error
    tigger-init > /dev/null
    tigger-commit # should error => usage error
    tigger-commit asdf # should error => usage error
    tigger-commit -m # should error => usage error
    tigger-commit -a -m # should error => usage error
    tigger-commit -m test # should error => nothing to commit

    touch a 
    tigger-commit -a -m test # should error => nothing to commit
    tigger-add a 
    tigger-commit -m test # should succeed

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    echo "tigger-commit: error: tigger repository directory .tigger not found"
    echo "tigger-commit: error: tigger repository directory .tigger not found"
    echo "usage: tigger-commit [-a] -m commit-message"
    echo "usage: tigger-commit [-a] -m commit-message"
    echo "usage: tigger-commit [-a] -m commit-message"
    echo "usage: tigger-commit [-a] -m commit-message"
    echo "nothing to commit"
    echo "nothing to commit"
    echo "Committed as commit 0"

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
