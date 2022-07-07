#!/bin/dash

######################################################################
# Test Script No. 2
# Subset 0 
# 
# Testing commands:
# - tigger-log
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp

    tigger-log # should error => .tigger does not exist
    tigger-log test # should error => .tigger does not exist > usage error
    tigger-init > /dev/null
    tigger-log test # should error => usage error
    tigger-log # should succeed => empty output

    touch a 
    tigger-add a
    tigger-commit -m test > /dev/null
    tigger-log # should succeed => 1 line of output

    touch b
    tigger-add b
    tigger-commit -m test2 > /dev/null
    tigger-log # should succeed => 2 lines of output

    rm -rf .tigger && rm *
    tigger-init > /dev/null

    count=0
    while [ "$count" -le 10 ]
    do 
        touch "$count"
        tigger-add "$count"
        tigger-commit -m "count test $count" > /dev/null
        count=$((count + 1))
    done

    tigger-log # should succeed => 11 outputs in numerical order

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    echo "tigger-log: error: tigger repository directory .tigger not found"
    echo "tigger-log: error: tigger repository directory .tigger not found"
    echo "usage: tigger-log"
    echo "0 test"
    echo "1 test2"
    echo "0 test"
    echo "10 count test 10"
    echo "9 count test 9"
    echo "8 count test 8"
    echo "7 count test 7"
    echo "6 count test 6"
    echo "5 count test 5"
    echo "4 count test 4"
    echo "3 count test 3"
    echo "2 count test 2"
    echo "1 count test 1"
    echo "0 count test 0"

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
