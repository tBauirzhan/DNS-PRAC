#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/file-handler.sh"

declare -A DNSHandler

DNSHandler["add"]="AddDNS"
DNSHandler["print"]="PrintDNS"

AddDNS() {
    local ip="$1"
    local name="$2"
    FileHandler_Invoke write $ip $name
    sleep 2
    clear
}

PrintDNS() {
    readFile=$(FileHandler_Invoke read)
    if [[ -z "$readFile" ]];then
        sleep 2
        clear
        return 1
    fi

        echo "📄 DNS-записи:"
        while IFS= read -r line; do
            ip=$(echo "$line" | awk '{print $1}')
            name=$(echo "$line" | awk '{print $2}')
            if [[ -n "$ip" && -n "$name" ]]; then
                echo "$name: $ip"
            fi
        done <<< "$outputFile"
}

DNSHandler_Invoke() {
    local method=$1
    shift
    ${DNSHandler["$method"]} "$@"
}


