#!/bin/bash


set -u
set -e

num1=$#
num2=("$@")
sum=${num2[0]}

for (( i=1; i<num1; i++ ))
do
	sum=$(( sum+${num2[i]} ))
done


echo "the total sum is : $sum"
