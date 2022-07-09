#!/bin/dash

######################################################################
# Test Script No. 7
# Subset 2
# 
# Testing commands:
# - tigger-branch
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp || exit

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    mkdir temp && cd temp || exit
    
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
