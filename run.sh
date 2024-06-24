#!/bin/bash
docker build -t pokerogue_server:latest .

docker stop pokerogue_server
docker rm pokerogue_server

source /home/dakurei/pokerogue_credentials.sh
docker run --name pokerogue_server --network databases --restart unless-stopped --ip 172.18.3.5 -d pokerogue_server:latest --dbaddr "$pokerogue_db_host" --dbuser "$pokerogue_db_user" --dbpass "$pokerogue_db_pass" --dbname "$pokerogue_db_name"
