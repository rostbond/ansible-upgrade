#!/usr/bin/env bash

# Creating JSON with hosts list

# Header
echo '{'
echo '  "lxc": {'
echo '    "hosts": ['


first=true
for vmid in $(pct list | awk 'NR>1 {print $1}'); do
    ip=$(pct exec "$vmid" -- ip -4 addr show scope global 2>/dev/null \
        | awk '/inet /{print $2}' | cut -d/ -f1 | head -n1)

    if [[ -n "$ip" ]]; then
        if [ "$first" = true ]; then
            first=false
        else
            echo ','
        fi
        echo -n "      \"$ip\""
    fi
done

# Footer
echo
echo '    ]'
echo '  },'
echo '  "_meta": {'
echo '    "hostvars": {}'
echo '  }'
echo '}'
