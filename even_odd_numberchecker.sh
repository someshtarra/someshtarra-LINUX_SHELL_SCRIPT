#!/bin/bash

echo "enter the number : "

read number

if [[ $number -ge 0 ]]; then
	if (( number%2==0 )); then
	    echo "EVEN NUMBER"
	else
	    echo "ODD NUMBER"
	fi
else
    
   echo "please enter the positive integer "

fi

