# MailCatcher

FROM fgrehm/ventriloquist-base
MAINTAINER Fabio Rehm "fgrehm@gmail.com"

RUN apt-get install -y ruby ruby-dev sqlite3 libsqlite3-dev && apt-get clean
RUN gem install mailcatcher --no-ri --no-rdoc

EXPOSE 1025:1025
EXPOSE 1080:1080
CMD    ["/usr/local/bin/mailcatcher", "-f", "--ip", "0.0.0.0"]
