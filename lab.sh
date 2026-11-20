
#!/usr/bin/env bash
# Лабораторна: дерево каталогів, файли, копіювання, перевірка email, пошук 404
set -euo pipefail
cd "$(dirname "$0")"
source ./config.env

ROOT="$SURNAME"

# 9. Створення дерева каталогів
mkdir -p "$ROOT/DEE" "$ROOT/SEE" "$ROOT/SSS"

# Створення файлів
echo "$EMAIL" > "$ROOT/DEE/$FIRSTNAME.txt"
echo "Група: $GROUP" > "$ROOT/SSS/$SURNAME.txt"
echo "Дата виконання: $DATE" >> "$ROOT/SSS/$SURNAME.txt"

# 10. Копіювання файлів у кореневий каталог
cp "$ROOT/DEE/$FIRSTNAME.txt" "$ROOT/"
cp "$ROOT/SSS/$SURNAME.txt" "$ROOT/"

# 11. Перевірка email регулярним виразом
if grep -Eq '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' "$ROOT/DEE/$FIRSTNAME.txt"; then
    echo "Email перевірку пройдено успішно."
else
    echo "Помилка: некоректна електронна пошта."
    exit 1
fi

# 13. Пошук помилок 404 в Apache-логах
if [[ -f "$LOGFILE" ]]; then
    count=$(grep -Ec 'HTTP/[0-9.]+" 404 ' "$LOGFILE" || true)
    echo "Кількість 404: $count"
    echo "Повідомлення про помилки 404:"
    grep -E 'HTTP/[0-9.]+" 404 ' "$LOGFILE" || true
else
    echo "Apache-лог не знайдено: $LOGFILE"
fi

