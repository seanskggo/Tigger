#!/bin/dash

######################################################################
# Test Script No. 5
# Subset 1
# 
# Testing commands:
# - tigger-status
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp

    tigger-status # should error => .tigger does not exist
    tigger-status test # should error => .tigger does not exist > usage error
    tigger-init > /dev/null
    tigger-status # should succeed

    # Case 1: dir, index and commit all exists
    rm -rf .tigger && rm -f * && tigger-init > /dev/null
    touch a
    tigger-add a
    tigger-commit -m test > /dev/null
    tigger-status # dir == index == commit
    echo "changed" > a
    tigger-status # dir != index == commit
    tigger-add a
    tigger-status # dir == index != commit
    echo "changed again" > a
    tigger-status # dir != index != commit
    # Case 2: dir and index exists
    rm -rf .tigger && rm -f * && tigger-init > /dev/null
    touch a
    tigger-add a
    tigger-status # dir == index
    echo "changed" > a
    tigger-status # dir != index
    # Case 3: dir and commit exists
    rm -rf .tigger && rm -f * && tigger-init > /dev/null
    touch a
    tigger-add a
    tigger-commit -m test > /dev/null
    rm a
    tigger-add a
    touch a
    tigger-status # dir == commit
    echo "changed" > a
    tigger-status # dir != commit
    # Case 4: index and commit exists
    rm -rf .tigger && rm -f * && tigger-init > /dev/null
    touch a
    tigger-add a
    tigger-commit -m test > /dev/null
    rm a
    tigger-status # index == commit
    echo "changed" > a
    tigger-add a
    rm a
    tigger-status # index != commit
    # Case 5: dir exists
    rm -rf .tigger && rm -f * && tigger-init > /dev/null
    touch a
    tigger-status
    # Case 6: index exists
    rm -rf .tigger && rm -f * && tigger-init > /dev/null
    touch a
    tigger-add a 
    rm a
    tigger-status
    # Case 7: commit exists
    rm -rf .tigger && rm -f * && tigger-init > /dev/null
    touch a
    tigger-add a 
    tigger-commit -m test > /dev/null
    rm a
    tigger-add a 
    tigger-status

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    mkdir temp && cd temp

    2041 tigger-status # should error => .tigger does not exist
    2041 tigger-status test # should error => .tigger does not exist > usage error
    2041 tigger-init > /dev/null
    2041 tigger-status # should error => usage error

    # Case 1: dir, index and commit all exists
    rm -rf .tigger && rm -f * && 2041 tigger-init > /dev/null
    touch a
    2041 tigger-add a
    2041 tigger-commit -m test > /dev/null
    2041 tigger-status # dir == index == commit
    echo "changed" > a
    2041 tigger-status # dir != index == commit
    2041 tigger-add a
    2041 tigger-status # dir == index != commit
    echo "changed again" > a
    2041 tigger-status # dir != index != commit
    # Case 2: dir and index exists
    rm -rf .tigger && rm -f * && 2041 tigger-init > /dev/null
    touch a
    2041 tigger-add a
    2041 tigger-status # dir == index
    echo "changed" > a
    2041 tigger-status # dir != index
    # Case 3: dir and commit exists
    rm -rf .tigger && rm -f * && 2041 tigger-init > /dev/null
    touch a
    2041 tigger-add a
    2041 tigger-commit -m test > /dev/null
    rm a
    2041 tigger-add a
    touch a
    2041 tigger-status # dir == commit
    echo "changed" > a
    2041 tigger-status # dir != commit
    # Case 4: index and commit exists
    rm -rf .tigger && rm -f * && 2041 tigger-init > /dev/null
    touch a
    2041 tigger-add a
    2041 tigger-commit -m test > /dev/null
    rm a
    2041 tigger-status # index == commit
    echo "changed" > a
    2041 tigger-add a
    rm a
    2041 tigger-status # index != commit
    # Case 5: dir exists
    rm -rf .tigger && rm -f * && 2041 tigger-init > /dev/null
    touch a
    2041 tigger-status
    # Case 6: index exists
    rm -rf .tigger && rm -f * && 2041 tigger-init > /dev/null
    touch a
    2041 tigger-add a 
    rm a
    2041 tigger-status
    # Case 7: commit exists
    rm -rf .tigger && rm -f * && 2041 tigger-init > /dev/null
    touch a
    2041 tigger-add a 
    2041 tigger-commit -m test > /dev/null
    rm a
    2041 tigger-add a 
    2041 tigger-status

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
    # diff -y a b | cat -n | grep -v -e '($'  
    diff a b 
fi

rm a b
