#!/bin/bash
source /home/dakurei/pokerogue_credentials.sh
docker run --rm --network databases pokerogue_server:latest --vouchergift --vouchergiftall --vouchergifttype "$1" --vouchergiftamount "$2" --dbaddr "$pokerogue_db_host" --dbuser "$pokerogue_db_user" --dbpass "$pokerogue_db_pass" --dbname "$pokerogue_db_name"
