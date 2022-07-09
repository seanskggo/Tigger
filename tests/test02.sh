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

    mkdir temp && cd temp || exit

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

    rm -rf .tigger && rm ./*
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

    mkdir temp && cd temp || exit

    2041 tigger-log 
    2041 tigger-log test 
    2041 tigger-init > /dev/null
    2041 tigger-log test 
    2041 tigger-log 

    touch a 
    2041 tigger-add a
    2041 tigger-commit -m test > /dev/null
    2041 tigger-log 

    touch b
    2041 tigger-add b
    2041 tigger-commit -m test2 > /dev/null
    2041 tigger-log 

    rm -rf .tigger && rm ./*
    2041 tigger-init > /dev/null

    count=0
    while [ "$count" -le 10 ]
    do 
        touch "$count"
        2041 tigger-add "$count"
        2041 tigger-commit -m "count test $count" > /dev/null
        count=$((count + 1))
    done

    2041 tigger-log 

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
