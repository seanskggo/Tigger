#!/bin/dash

######################################################################
# Test Script No. 3
# Subset 0 
# 
# Testing commands:
# - tigger-show
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp || exit

    tigger-show # should error => .tigger does not exist
    tigger-show test # should error => .tigger does not exist > usage error
    tigger-init > /dev/null
    tigger-show # should error => usage error
    tigger-show test # should error => invalid object
    tigger-show : # should error => invalid filename
    tigger-show test:test # should error => unknown commit
    tigger-show 0:test # should error => unknown commit
    tigger-show 0: # should error => unknown commit > invalid filename 

    echo "test 1" > a
    echo "test 2" > b
    echo "test 3" > c
    tigger-add a b 
    tigger-commit -m test > /dev/null
    tigger-show 0:a # should succeed 
    tigger-show :a # should succeed 
    echo "add" >> a
    tigger-show :a # should succeed => no change
    tigger-add a
    tigger-show :a # should succeed => changed
    tigger-commit -m test > /dev/null
    tigger-show :a # should succeed => no change from previous
    tigger-show :b # should succeed 
    tigger-show 100:a # should error => unknown commit
    tigger-show 100:y # should error => unknown commit > unknown file in commit
    tigger-show 0:y # should error => unknown commit > unknown file 
    tigger-show :y # should error => unknown commit > unknown file in index

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    mkdir temp && cd temp || exit

    2041 tigger-show # should error => .tigger does not exist
    2041 tigger-show test # should error => .tigger does not exist > usage error
    2041 tigger-init > /dev/null
    2041 tigger-show # should error => usage error
    2041 tigger-show test # should error => invalid object
    2041 tigger-show : # should error => invalid filename
    2041 tigger-show test:test # should error => unknown commit
    2041 tigger-show 0:test # should error => unknown commit
    2041 tigger-show 0: # should error => unknown commit > invalid filename 

    echo "test 1" > a
    echo "test 2" > b
    echo "test 3" > c
    2041 tigger-add a b 
    2041 tigger-commit -m test > /dev/null
    2041 tigger-show 0:a 
    2041 tigger-show :a 
    echo "add" >> a
    2041 tigger-show :a 
    2041 tigger-add a
    2041 tigger-show :a 
    2041 tigger-commit -m test > /dev/null
    2041 tigger-show :a 
    2041 tigger-show :b 
    2041 tigger-show 100:a 
    2041 tigger-show 100:y 
    2041 tigger-show 0:y 
    2041 tigger-show :y 

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
