#!/bin/bash

# Check if php-fpm is running
if ! pgrep "php-fpm" >/dev/null; then
    php-fpm -D
fi

# Check if nginx is running
if ! pgrep "nginx" >/dev/null; then
    service nginx start
fi

echo "Dev server is started."

tail -f /dev/null
