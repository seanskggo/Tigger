#!/bin/dash

######################################################################
# Test Script No. 8
# Subset 2
# 
# Testing commands:
# - tigger-checkout
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp || exit

    tigger-checkout # should fail => no .tigger
    tigger-checkout branch # should fail => no .tigger
    tigger-checkout branch branch # should fail => no .tigger > usage error
    tigger-init > /dev/null
    tigger-checkout # should error => must have first commit > usage error
    tigger-checkout test test # should error => must have first commit > usage error
    touch a 
    tigger-add a
    tigger-commit -m test
    tigger-checkout # should error => usage erorr
    tigger-checkout test test # should error => usage error
    tigger-checkout non_existent_branch # should error => non existent branch
    tigger-checkout master # should error => already on master

    # Test commit with checkout behaviour
    rm -rf .tigger && rm -f ./*
    echo "new" > a
    tigger-init
    tigger-add a
    tigger-commit -m test
    tigger-branch branch1
    tigger-checkout branch1
    cat a && ls
    echo "not new" > a
    cat a && ls
    tigger-checkout master
    cat a && ls
    tigger-checkout branch1
    cat a && ls
    tigger-commit -a -m test
    cat a && ls
    tigger-checkout master
    cat a && ls

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    mkdir temp && cd temp || exit

    2041 tigger-checkout # should fail => no .tigger
    2041 tigger-checkout branch # should fail => no .tigger
    2041 tigger-checkout branch branch # should fail => no .tigger > usage error
    2041 tigger-init > /dev/null
    2041 tigger-checkout # should error => must have first commit > usage error
    2041 tigger-checkout test test # should error => must have first commit > usage error
    touch a 
    2041 tigger-add a
    2041 tigger-commit -m test
    2041 tigger-checkout # should error => usage erorr
    2041 tigger-checkout test test # should error => usage error
    2041 tigger-checkout non_existent_branch # should error => non existent branch
    2041 tigger-checkout master # should error => already on master

    # Test commit with checkout behaviour
    rm -rf .tigger && rm -f ./*
    echo "new" > a
    2041 tigger-init
    2041 tigger-add a
    2041 tigger-commit -m test
    2041 tigger-branch branch1
    2041 tigger-checkout branch1
    cat a
    echo "not new" > a
    cat a && ls
    2041 tigger-checkout master
    cat a && ls
    2041 tigger-checkout branch1
    cat a && ls
    2041 tigger-commit -a -m test
    cat a && ls
    2041 tigger-checkout master
    cat a && ls

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
