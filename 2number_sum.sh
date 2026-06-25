#!/bin/bash

set -e

echo "Enter the 1st number :"

read num1

echo "Enter the second number :"

read num2

sum=$((num1+num2))
echo "the sum of $num1 and $num2 is $sum"
