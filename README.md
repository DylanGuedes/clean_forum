# ForumApp

1. `docker-compose up -d`
2. `docker exec -it db /bin/sh`
3. `psql -U postgres`
4. `create database forumdev;`
5. `docker exec -it server /bin/sh`
6. `rake db:migrate`

