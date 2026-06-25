#!/bin/bash

echo "enter the first number : "
read num1
echo "enter the second number : "
read num2

product=$(( num1*num2 ))
echo "the product of $num1 and $num2 is $product"
