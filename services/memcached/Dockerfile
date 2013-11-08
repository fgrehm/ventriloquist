# Memcached

FROM fgrehm/ventriloquist-base

# prevent apt from starting postgres right after the installation
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get install -y -q memcached && apt-get clean

# allow autostart again
RUN rm /usr/sbin/policy-rc.d

EXPOSE 11211
CMD    ["/usr/bin/memcached", "-u", "daemon"]
