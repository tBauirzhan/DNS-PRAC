#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/file-handler.sh"

declare -A DNSHandler

DNSHandler["add"]="AddDNS"
DNSHandler["print"]="PrintDNS"
DNSHandler["delete"]="DeleteDNS"

AddDNS() {
    local ip="$1"
    local name="$2"
    FileHandler_Invoke write $ip $name
    sleep 2
    clear
}

PrintDNS() {
    readFile=$(FileHandler_Invoke read)
    if [[ "$1" == "val" ]]; then
	isVal=1
    else
	isVal=NULL
    fi

    if [[ -z "$readFile" ]];then
        sleep 2
        clear
        return 1
    fi
    i=1
        echo "📄 DNS-записи:"
        while IFS= read -r line; do
            ip=$(echo "$line" | awk '{print $1}')
            name=$(echo "$line" | awk '{print $2}')
            if [[ -n "$ip" && -n "$name" ]]; then
                echo "$i) $name: $ip"
                ((i++))
	    fi
        done <<< "$readFile"
}

DeleteDNS()
{
	mapfile -t lines < "$DNS_FILE"

	echo "📄 DNS-записи:"
	for i in "${!lines[@]}"; do
	    ip=$(echo "${lines[$i]}" | awk '{print $1}')
	    name=$(echo "${lines[$i]}" | awk '{print $2}')
	    echo "$((i+1))) $ip: $name"
	done

	read -p "Выбери номер для удаления: " choice
	index=$((choice - 1))

	if [[ -z "${lines[$index]}" ]]; then
	    echo "❌ Неверный выбор"
	    return 1
	fi

	line_to_delete="${lines[$index]}"
	escaped=$(printf '%s\n' "$line_to_delete" | sed 's/[][\.*^$/]/\\&/g')

	sudo sed -i "/^$escaped$/d" "$DNS_FILE"

	echo "🗑 Удалено: $line_to_delete"
}

DNSHandler_Invoke() {
    local method=$1
    shift
    ${DNSHandler["$method"]} "$@"
}


