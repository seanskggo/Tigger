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

    tigger-branch 
    tigger-branch branch
    tigger-branch test test 
    tigger-init > /dev/null
    tigger-branch 
    tigger-branch branch 
    tigger-branch -d branch 
    tigger-branch test test 

    # Master branch works
    touch a 
    tigger-add a 
    tigger-commit -m test
    tigger-branch # should succeed => master only
    # Create and commit on multiple branches
    tigger-branch branch1 
    echo "changed" > a
    tigger-commit -a -m test
    tigger-branch # should succeed => master & branch1
    tigger-branch branch1 
    echo "changed" >> a
    tigger-commit -a -m test
    tigger-branch # should succeed => master & branch1
    tigger-branch branch1 # should error => branch already exists
    tigger-branch branch2 # should succeed
    echo "changed" >> a
    tigger-commit -a -m test
    tigger-branch # should succeed => master & branch1 & branch 2

    # Delete a branch and commit
    tigger-branch -d non_existent_branch # should error => branch does not exist
    tigger-branch -d master # should error => cannot delete master
    tigger-branch -d branch2 # should succeed
    tigger-branch # should succeed => master & branch 2
    echo "changed" >> a
    tigger-commit -a -m test # should be commit no. 3

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# Created from 2041 reference implementation
make_answers () {

    mkdir temp && cd temp || exit

    2041 tigger-branch 
    2041 tigger-branch branch
    2041 tigger-branch test test 
    2041 tigger-init > /dev/null
    2041 tigger-branch 
    2041 tigger-branch branch 
    2041 tigger-branch -d branch 
    2041 tigger-branch test test 

    # Master branch works
    touch a 
    2041 tigger-add a 
    2041 tigger-commit -m test
    2041 tigger-branch # should succeed => master only
    # Create and commit on multiple branches
    2041 tigger-branch branch1 
    echo "changed" > a
    2041 tigger-commit -a -m test
    2041 tigger-branch # should succeed => master & branch1
    2041 tigger-branch branch1 
    echo "changed" >> a
    2041 tigger-commit -a -m test
    2041 tigger-branch # should succeed => master & branch1
    2041 tigger-branch branch1 # should error => branch already exists
    2041 tigger-branch branch2 # should succeed
    echo "changed" >> a
    2041 tigger-commit -a -m test
    2041 tigger-branch # should succeed => master & branch1 & branch 2

    # Delete a branch and commit
    2041 tigger-branch -d non_existent_branch # should error => branch does not exist
    2041 tigger-branch -d master # should error => cannot delete master
    2041 tigger-branch -d branch2 # should succeed
    2041 tigger-branch # should succeed => master & branch 2
    echo "changed" >> a
    2041 tigger-commit -a -m test # should be commit no. 3

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
