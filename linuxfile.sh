#!/bin/bash
# Prompt for the amount and currencies
read -p "Enter the amount: " amount
read -p "Enter the source currency (e.g., USD): " source_currency
read -p "Enter the target currency (e.g., EUR): " target_currency

# Replace 'YOUR API KEY' with your actual API key
api_key="4ad867ae044e28a67cf6cafc"

# Use an API to convert currency
conversion_result=$(curl -s "https://v6.exchangerate-api.com/v6/$api_key/pair/$source_currency/$target_currency/$amount")

# Check if the API request was successful and if JSON contains the converted amount
if echo "$conversion_result" | jq -e '.conversion_result' > /dev/null; then
    # Extract the converted amount from the API response
    converted_amount=$(echo "$conversion_result" | jq -r '.conversion_result')
    # Display the converted amount
    echo "Converted Amount: $converted_amount $target_currency"
else
    # Display error if the conversion failed
    error_message=$(echo "$conversion_result" | jq -r '.["error-type"]')
    echo "Error: $error_message"
fi