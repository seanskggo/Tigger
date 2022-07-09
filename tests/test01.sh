#!/bin/dash

######################################################################
# Test Script No. 1
# Subset 0 
# 
# Testing commands:
# - tigger-add 
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp || exit

    tigger-init
    touch a b
    tigger-add a b # should succeed
    tigger-add c # should error => non existent file
    rm -rf .tigger
    tigger-add a b # should error => no .tigger present
    tigger-add c # should error => no .tigger error > non existent file error
    tigger-init
    tigger-add # should error => usage error
    tigger-add a # should error => usage error
    rm a 
    tigger-add a # should succeed (adding deleted file to index)

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    mkdir temp && cd temp || exit

    2041 tigger-init
    touch a b
    2041 tigger-add a b 
    2041 tigger-add c 
    rm -rf .tigger
    2041 tigger-add a b 
    2041 tigger-add c 
    2041 tigger-init
    2041 tigger-add 
    2041 tigger-add a 
    rm a 
    2041 tigger-add a 

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
