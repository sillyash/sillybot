#!/bin/bash
# Usage: discohook [--ban <userid>] <json_file> <webhook_url>

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 [--ban <userid>] <json_file> <webhook_url>"
    exit 1
fi

if [ "$1" == "--ban" ]; then
    if [ "$#" -ne 3 ]; then
        echo "Usage: $0 --ban <userid> <webhook_url>"
        exit 1
    fi

    user_id=$2
    webhook_url=$3

    json="{
        \"username\": \"Antiraciste Bot\",
        \"avatar_url\": \"https://discohook.org/static/discord-avatar.png\",
        \"content\": null,
        \"embeds\": [{
            \"title\": \"cancel $(curl -s https://discordlookup.mesalytic.moe/v1/user/$user_id | jq -r '.username')\",
            \"description\": \"<@$user_id> raciste\",
            \"color\": 16777215,
            \"author\": {
                \"name\": \"Antiraciste Bot\",
                \"icon_url\": \"https://discohook.org/static/discord-avatar.png\"
            },
            \"image\": {
                \"url\": \"https://media1.tenor.com/m/MCJFAavmyJwAAAAd/rizzler-the-rizzler.gif\"
            }
        }]
    }"

    if ! curl --output /dev/null --silent --head --fail "$webhook_url"; then
        echo "Error: Invalid webhook URL '$webhook_url'."
        exit 1
    fi

    curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X POST "$webhook_url" --data "$json"

    echo ""
else
    json_file=$1
    webhook_url=$2

    if [ ! -f "$json_file" ]; then
        echo "Error: JSON file '$json_file' not found."
        exit 1
    fi

    if ! curl --output /dev/null --silent --head --fail "$webhook_url"; then
        echo "Error: Invalid webhook URL '$webhook_url'."
        exit 1
    fi

    curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X POST "$webhook_url" --data @"$json_file"

    echo ""
fi