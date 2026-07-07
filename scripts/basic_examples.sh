#!/bin/bash
# ==============================================================================
# Basic Bash Scripting Examples
# ==============================================================================
# This script contains fundamental concepts of shell scripting to help you learn
# and understand variables, conditionals, loops, functions, and arrays.
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Shell Scripting Fundamentals ==="

# ------------------------------------------------------------------------------
# 1. Variables & String Manipulation
# ------------------------------------------------------------------------------
echo -e "\n--- 1. Variables & Strings ---"
USERNAME="john"
USER_ID=1050

echo "Original Username: $USERNAME"
echo "Concatenation: ${USERNAME}_backup"
echo "Substring (first 3 chars): ${USERNAME:0:3}"
echo "Uppercase: ${USERNAME^^}"

# ------------------------------------------------------------------------------
# 2. Conditionals (if-else)
# ------------------------------------------------------------------------------
echo -e "\n--- 2. Conditionals ---"

# File test: Check if /etc/passwd exists
if [ -f /etc/passwd ]; then
    echo "File /etc/passwd exists."
fi

# Numeric comparison
if [ "$USER_ID" -gt 1000 ]; then
    echo "User ID $USER_ID is greater than 1000 (Non-system user)."
else
    echo "User ID $USER_ID is 1000 or less (System user)."
fi

# String comparison
if [ "$USERNAME" = "admin" ]; then
    echo "Admin privileges detected."
else
    echo "Regular user: $USERNAME"
fi

# ------------------------------------------------------------------------------
# 3. Loops
# ------------------------------------------------------------------------------
echo -e "\n--- 3. Loops ---"

# For loop over numbers
echo "For loop (1 to 5):"
for i in {1..5}; do
    echo "  Index: $i"
done

# While loop reading a string
echo "While loop (simulating reading lines):"
echo -e "Line1\nLine2\nLine3" | while read -r line; do
    echo "  Read: $line"
done

# ------------------------------------------------------------------------------
# 4. Arrays
# ------------------------------------------------------------------------------
echo -e "\n--- 4. Arrays ---"

# Declare an array
servers=("web1" "web2" "web3")

# Access specific element (0-indexed)
echo "First server: ${servers[0]}"

# Print all elements
echo "All servers: ${servers[*]}"

# Array length
echo "Number of servers: ${#servers[@]}"

# Loop through array elements
echo "Iterating through servers:"
for server in "${servers[@]}"; do
    echo "  Server node: $server"
done

# Add a new element to array
servers+=("web4")
echo "Added web4. Total now: ${#servers[@]}"

# ------------------------------------------------------------------------------
# 5. Functions
# ------------------------------------------------------------------------------
echo -e "\n--- 5. Functions ---"

# Define a function
greet_user() {
    local name=$1
    local id=$2
    echo "Hello, $name! Your User ID is $id."
}

# Invoke the function
greet_user "$USERNAME" "$USER_ID"

echo -e "\n=== Execution Finished successfully ==="
