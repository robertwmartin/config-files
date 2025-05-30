#!/bin/bash

INPUT="proton-pass-export.csv"
OUTPUT="passwordsafe-import.txt"

# Remove old output file
> "$OUTPUT"

# Skip header
tail -n +2 "$INPUT" | while IFS=',' read -r type name url email username password note totp createTime modifyTime vault; do

    # Combine username and email
    login="$username"
    if [[ -n "$email" && "$email" != "$username" ]]; then
        login="$username / $email"
    fi

    echo "[$name]" >> "$OUTPUT"
    echo "UserName: $login" >> "$OUTPUT"
    echo "Password: $password" >> "$OUTPUT"
    [[ -n "$note" ]] && echo "Notes: $note" >> "$OUTPUT"
    [[ -n "$url" ]] && echo "URL: $url" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
    echo "----" >> "$OUTPUT"
done

echo "✅ Reformatted for PasswordSafe KeePass V1 TXT import: $OUTPUT"

