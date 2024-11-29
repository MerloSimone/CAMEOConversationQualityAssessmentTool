#!/bin/bash

# Function to validate names (contains only letters and spaces)
is_valid_name() {
    [[ "$1" =~ ^[A-Za-z\ ]+$ ]]
    return $?
}

echo "NOTE: the data that you will be required to enter must be correct, otherwise you will not be considered for this work."

# Prompt for first name
while true; do
    read -p "Insert your First Name: " name
    if [[ ${#name} -ge 2 ]] && is_valid_name "$name"; then
        break
    else
        echo "Insert your REAL First Name."
    fi
done

# Replace spaces with underscores in name
name=${name// /_}

# Prompt for last name
while true; do
    read -p "Insert your Last Name: " surname
    if [[ ${#surname} -ge 2 ]] && is_valid_name "$surname"; then
        break
    else
        echo "Insert your REAL Last Name."
    fi
done

# Replace spaces with underscores in surname
surname=${surname// /_}

# Prompt for registration number
while true; do
    read -p "Insert your registration number (matricola): " reg_num
    if [[ ${#reg_num} -gt 2 ]]; then
        break
    else
        echo "Insert a valid registration number (matricola)."
    fi
done

# Replace spaces with underscores in reg_num
reg_num=${reg_num// /_}

# Create the account.txt file
output_file="./account.txt"
username="${name}.${surname}.${reg_num}@cameo.dei.unipd.it"
password="password12345"

echo "Username: $username"
echo "Password: $password"
echo "$username" > "$output_file"
echo "$password" >> "$output_file"

echo "Account information saved to $output_file."