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
    tigger-rm                                       
    tigger-rm --force                               
    tigger-rm --force --cached                      
    tigger-rm a                                     

    touch a                                         
    tigger-rm a                                     
    tigger-add a                                    
    tigger-rm a                                     
    tigger-commit -m test > /dev/null               
    tigger-rm a # should succeed
    tigger-rm a # should fail after removal

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
