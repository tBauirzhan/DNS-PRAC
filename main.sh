#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/dns-handler.sh"

while true; do
    echo "===== Главное меню ====="
    echo "1. Добавить DNS"
    echo "2. Удалить  DNS"
    echo "3. Показать DNS"
    echo "4. Тесты"
    echo "5. Выход"
    read -p "Выберите пункт: " choice

    case $choice in
        1)
            clear
            echo "[!] Вы выбрали: Добавить DNS"
            read -p "Введите имя DNS(Пример esxi.local): " name
            read -p "Введите ип  DNS(Пример 192.168.1.1): " ip
            DNSHandler_Invoke add "$name" "$ip"
            ;;
        2)
	    clear
	    DNSHandler_Invoke delete
	    sleep 1
	    clear
	    ;;
	3)
            clear
            DNSHandler_Invoke print
	    read -p "Нажмите на любую кнопку для продолжение..."
	    clear
            ;;
        4)
            bash "$SCRIPT_DIR/test-handler.sh"
            ;;
        5)
            echo "Выход..."
            exit 0
            ;;
        *)
            echo "❌ Неверный выбор"
            ;;
    esac
done
