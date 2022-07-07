#!/bin/dash

######################################################################
# Test Script No. 4
# Subset 1
# 
# Testing commands:
# - tigger-rm
# 
# NOTE: Assumes tigger commands are added to PATH
######################################################################

######################################################################
# Tigger commands to be run
######################################################################

test_commands () {

    mkdir temp && cd temp

    tigger-rm # should error => .tigger does not exist > usage error
    tigger-rm test # should error => .tigger does not exist > unknown file
    tigger-init > /dev/null
    tigger-rm # should error => usage error              
    tigger-rm --force # should error => usage error         
    tigger-rm --force --cached # should error => usage error 

    tigger-rm a # should error => file not in repository
    touch a                                         
    tigger-rm a # should error => file not in repository
    tigger-add a                                     
    tigger-rm a # should error => file not in repository                               
    tigger-commit -m test > /dev/null               
    tigger-rm a # should succeed
    tigger-rm a # should fail after removal

    # tigger-rm 
    rm -rf .tigger && rm -f *
    tigger-init > /dev/null
    # Case 1: file and index differ (test both ways)
    echo "test" > a
    tigger-rm a
    tigger-add a
    tigger-rm a
    # Case 2: file and commit differ (+ test with deleted file)
    tigger-commit -m test > /dev/null
    echo "changed" > a
    tigger-rm a
    rm a
    tigger-rm a
    # Case 3: commit and index differ
    echo "new" > b
    tigger-add b
    tigger-commit -m test > /dev/null
    echo "changed" > b
    tigger-add b
    tigger-rm b
    # Case 4: commit, index file all differ
    echo "changed again" > b
    tigger-rm b

    cd .. && rm -rf temp

}

######################################################################
# Create file with expected answers
######################################################################

# 2041 reference implementation output
make_answers () {
    
    mkdir temp && cd temp

    2041 tigger-rm 
    2041 tigger-rm test 
    2041 tigger-init > /dev/null                         
    2041 tigger-rm                                       
    2041 tigger-rm --force                               
    2041 tigger-rm --force --cached                      
    2041 tigger-rm a                                     

    touch a                                         
    2041 tigger-rm a                                     
    2041 tigger-add a                                    
    2041 tigger-rm a                                     
    2041 tigger-commit -m test > /dev/null               
    2041 tigger-rm a 
    2041 tigger-rm a 

    # tigger-rm 
    rm -rf .tigger && rm -f *
    2041 tigger-init > /dev/null
    # Case 1: file and index differ (test both ways)
    echo "test" > a
    2041 tigger-rm a
    2041 tigger-add a
    2041 tigger-rm a
    # Case 2: file and commit differ (+ test with deleted file)
    2041 tigger-commit -m test > /dev/null
    echo "changed" > a
    2041 tigger-rm a
    rm a
    2041 tigger-rm a
    # Case 3: commit and index differ
    echo "new" > b
    2041 tigger-add b
    2041 tigger-commit -m test > /dev/null
    echo "changed" > b
    2041 tigger-add b
    2041 tigger-rm b
    # Case 4: commit, index file all differ
    echo "changed again" > b
    2041 tigger-rm b

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
    # diff -y a b | cat -n | grep -v -e '($'  
fi

rm a b
