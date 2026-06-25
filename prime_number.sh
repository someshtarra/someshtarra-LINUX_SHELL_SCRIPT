#!/bin/bash

set -e
echo "ENTER THE NUMBER: "

read number
i=$number

if [[ $i -ge 1 ]]; then
    
	if [[ $i -eq 2 ]]; then
	     echo "Given number is prime number"

	elif [[ $i -eq 1 ]]; then
	     echo "given number is not a prime number"

	else

	    for ((j=2; j<i; j++))
	    do
		if ((i%j == 0)); then
			echo "given number is not a prime number"
			exit 0
		fi
	    done
	    
	    echo "given number is a prime number"
	fi

else
	echo "please enter the positive integer value"
fi


