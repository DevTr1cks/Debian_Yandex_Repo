#!/bin/bash

# Проверяем, выполняется ли скрипт от root
if [ "$(id -u)" -ne 0 ]; then
    echo "Этот скрипт должен быть запущен с правами root!" >&2
    exit 1
fi

# Создаем резервную копию текущего sources.list
echo "Создаю резервную копию /etc/apt/sources.list в /etc/apt/sources.list.bak..."
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Определяем версию Debian
DEBIAN_VERSION=$(lsb_release -sc)

# Основные репозитории Yandex для Debian
YA_DEB="http://mirror.yandex.ru/debian"
YA_SECURITY="http://mirror.yandex.ru/debian-security"

# Записываем новые репозитории
cat > /etc/apt/sources.list <<EOF
# Yandex Mirror для Debian ${DEBIAN_VERSION}
deb ${YA_DEB} ${DEBIAN_VERSION} main contrib non-free
deb ${YA_DEB} ${DEBIAN_VERSION}-updates main contrib non-free
deb ${YA_SECURITY} ${DEBIAN_VERSION}-security main contrib non-free
EOF

# Для Debian Sid (unstable) или Testing можно использовать:
# deb ${YA_DEB} unstable main contrib non-free

echo "Репозитории успешно заменены на Yandex Mirror!"
echo "Обновляю список пакетов..."

apt update

echo "Готово! Все репозитории заменены на Yandex Mirror."