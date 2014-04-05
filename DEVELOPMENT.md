# Development notes

[Vagrantfile for testing](/development/Vagrantfile)

## Testing services

```sh
redis-cli ping
psql
mysql -e 'SHOW DATABASES'

# Memcached: run STATS then QUIT
telnet localhost 11211

# MailCatcher
curl localhost:1080

# RethinkDB
curl localhost:8080

# ElasticSearch
curl $(docker port $(cat /var/lib/ventriloquist/cids/es) 9200)
```

## Testing platforms

```sh
rvm list
ruby -v
nvm list
node -v
pyenv versions
python --version
phantomjs -v
iex --version
erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell
```
