# NEXTCLOUD

version: '3.8'

services:
  # 1. Database (Wajib buat nyimpen data user)
  db:
    image: mariadb:10.6
    container_name: nextcloud_db
    restart: always
    command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    environment:
      MYSQL_ROOT_PASSWORD: passwordrahasia
      MYSQL_PASSWORD: password_db_cloud
      MYSQL_DATABASE: nextcloud
      MYSQL_USER: nextcloud
    volumes:
      - db_data:/var/lib/mysql

  # 2. Aplikasi Nextcloud
  app:
    image: nextcloud:latest
    container_name: nextcloud_app
    restart: always
    ports:
      - "8081:80"  # Kita pakai port 8081 (biar gak bentrok sama WP 8080)
    environment:
      MYSQL_HOST: db
      MYSQL_PASSWORD: password_db_cloud
      MYSQL_DATABASE: nextcloud
      MYSQL_USER: nextcloud
    volumes:
      - nextcloud_data:/var/www/html
    depends_on:
      - db

volumes:
  db_data:
  nextcloud_data:
