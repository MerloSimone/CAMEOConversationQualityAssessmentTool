#!/bin/bash

# File containing the account data
input_file="./account.txt"

# Check if the file exists
if [[ ! -f "$input_file" ]]; then
    echo "Error: $input_file does not exist."
    exit 1
fi

# Read the file and extract username and password
read -r username < "$input_file"
read -r password < <(tail -n 1 "$input_file")

# Display the formatted output
echo "Username: $username"
echo "Password: $password"