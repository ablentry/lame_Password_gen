#!/bin/bash

# Function to generate combinations
generate_combinations() {
    local words=("$@")
    local num_words=$1
    shift
    local combinations=()
    if [[ $num_words -eq 2 ]]; then
        for i in "${!words[@]}"; do
            for j in "${!words[@]}"; do
                combinations+=("${words[$i]}${words[$j]}")
            done
        done
    elif [[ $num_words -eq 3 ]]; then
        for i in "${!words[@]}"; do
            for j in "${!words[@]}"; do
                for k in "${!words[@]}"; do
                    combinations+=("${words[$i]}${words[$j]}${words[$k]}")
                done
            done
        done
    elif [[ $num_words -eq 4 ]]; then
        for i in "${!words[@]}"; do
            for j in "${!words[@]}"; do
                for k in "${!words[@]}"; do
                    for l in "${!words[@]}"; do
                        combinations+=("${words[$i]}${words[$j]}${words[$k]}${words[$l]}")
                    done
                done
            done
        done
    fi
    echo "${combinations[@]}"
}

# Prompt for number of words to add
read -p "How many words would you like to add to the list? " num_add_words

# Initialize an array to store the words
words=()

# Ask for words or load from file
read -p "Would you like to add words manually (m) or from a file (f)? " choice
if [[ "$choice" == "m" ]]; then
    for ((i=1; i<=num_add_words; i++)); do
        read -p "Enter word $i: " word
        words+=("$word")
    done
elif [[ "$choice" == "f" ]]; then
    read -p "Enter the path to the word list file: " file_path
    if [[ -f "$file_path" ]]; then
        while IFS= read -r line; do
            words+=("$line")
        done < "$file_path"
    else
        echo "File not found!"
        exit 1
    fi
else
    echo "Invalid choice!"
    exit 1
fi

# Prompt for number of words to combine
read -p "How many words would you like to combine? (2-4) " num_combine_words

if [[ $num_combine_words -lt 2 || $num_combine_words -gt 4 ]]; then
    echo "Invalid number of words to combine! Please choose between 2 and 4."
    exit 1
fi

# Generate combinations and save to password_list.txt
generate_combinations $num_combine_words "${words[@]}" > password_list.txt

echo "Password combinations saved to password_list.txt"
