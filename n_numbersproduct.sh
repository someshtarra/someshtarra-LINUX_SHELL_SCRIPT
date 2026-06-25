#!/bin/bash

num1=$#
num2=("$@")
product=$1

for (( i=1; i<num1; i++ ))
do
	product=$(( product*${num2[i]} ))
done

echo "the all product is : $product "

