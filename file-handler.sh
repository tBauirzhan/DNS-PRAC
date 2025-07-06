#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
DNS_FILE="/etc/dnsmasq.hosts"

declare -A FileHandler

FileHandler["write"]="WriteFile"
FileHandler["read"]="ReadFile"

WriteFile()
{
    if [[ -z "$1" || -z "$2" ]]; then
        echo "❌ Аргументы не корректные!"
        return 1
    fi

    output=$(echo "$1 $2" | sudo tee -a "$DNS_FILE")

    echo "Запись прошло успешно!"
    echo "$1 $2"

}

ReadFile()
{
    if [[ -f "$DNS_FILE" ]]; then
        cat "$DNS_FILE"
    else
        echo "❌ Файл не найден: $DNS_FILE" >&2
        return 1
    fi
}

FileHandler_Invoke()
{
    local method=$1
    shift
    ${FileHandler["$method"]} "$@"
}
