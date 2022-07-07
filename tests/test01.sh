#!/bin/dash

######################################################################
# Test Script No. 1
# Subset 0 & 1
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
    tigger-commit -a -m test # should error => nothing to commit
    echo 'changed' > a
    tigger-commit -m test # should error => nothing to commit
    tigger-commit -a -m test # should succeed

    touch b
    tigger-add b 
    tigger-commit -a -m test # should succeed
    tigger-commit -m test # should error => nothing to commit

    rm -rf .tigger && rm *
    tigger-init > /dev/null
    touch b
    tigger-add b 
    tigger-commit -m test # should succeed
    echo "changed" >> b
    tigger-commit -m test # should error => nothing to commit
    tigger-commit -a -m test # should succeed

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    mkdir temp && cd temp

    2041 tigger-commit 
    2041 tigger-commit asdf 
    2041 tigger-init > /dev/null
    2041 tigger-commit 
    2041 tigger-commit asdf 
    2041 tigger-commit -m 
    2041 tigger-commit -a -m 
    2041 tigger-commit -m test 

    touch a 
    2041 tigger-commit -a -m test 
    2041 tigger-add a 
    2041 tigger-commit -m test 
    2041 tigger-commit -a -m test 
    echo 'changed' > a
    2041 tigger-commit -m test 
    2041 tigger-commit -a -m test 

    touch b
    2041 tigger-add b 
    2041 tigger-commit -a -m test 
    2041 tigger-commit -m test 

    rm -rf .tigger && rm *
    2041 tigger-init > /dev/null
    touch b
    2041 tigger-add b 
    2041 tigger-commit -m test 
    echo "changed" >> b
    2041 tigger-commit -m test 
    2041 tigger-commit -a -m test

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
