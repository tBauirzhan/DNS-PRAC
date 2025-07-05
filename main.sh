#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"

source "$SCRIPT_DIR/file-handler.sh"
source "$SCRIPT_DIR/dns-handler.sh"

while true; do
    echo "===== Главное меню ====="
    echo "1. Добавить DNS"
    echo "2. Показать DNS"
    echo "3. Тесты"
    echo "4. Выход"
    read -p "Выберите пункт: " choice

    case $choice in
        1)
            clear
            echo "[!] Вы выбрали: Добавить DNS"
            AddDNS
            ;;
        2)
            echo "[!] Вы выбрали: Показать DNS"
            ;;
        3)
            echo "[!] Переход в подменю Тестов..."
            ;;
        4)
            echo "Выход..."
            exit 0
            ;;
        *)
            echo "❌ Неверный выбор"
            ;;
    esac
done
