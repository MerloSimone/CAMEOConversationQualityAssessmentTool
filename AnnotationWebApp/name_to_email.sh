#!/bin/bash

# Function to validate names (contains only letters and spaces)
is_valid_name() {
    [[ "$1" =~ ^[A-Za-z\ ]+$ ]]
    return $?
}

# File containing the IDs (one per line)
reg_num_file="./data/reg_num.txt"

out_reg_num_file="./data/current_reg_num.txt"

# Read registration numbers from the file into an array
reg_nums=()
while IFS= read -r line; do
    reg_nums+=("$line")
done < "$reg_num_file"




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

    found=0
    for id in "${reg_nums[@]}"; do
        if [[ "$reg_num" == "$id" ]]; then
            found=1
            echo "$id" > "$out_reg_num_file" # Save the found ID to the output file
            break
        fi
    done
    
    if [[ ${#reg_num} -gt 2 ]]; then
        if [[ $found -eq 1 ]]; then
            break
        else
            echo "The registration number (matricola) provided has not been enabled or is not valid."
        fi
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