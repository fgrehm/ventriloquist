# Ventriloquist

[![Build Status](https://travis-ci.org/fgrehm/ventriloquist.png?branch=master)](https://travis-ci.org/fgrehm/ventriloquist) [![Gem Version](https://badge.fury.io/rb/ventriloquist.png)](http://badge.fury.io/rb/ventriloquist) [![Code Climate](https://codeclimate.com/github/fgrehm/ventriloquist.png)](https://codeclimate.com/github/fgrehm/ventriloquist) [![Gittip](http://img.shields.io/gittip/fgrehm.svg)](https://www.gittip.com/fgrehm/)

> **ven·tril·o·quist**: _(noun)_ a person who can speak or utter sounds so that
  they seem to come from somewhere else, esp. an entertainer who makes their voice
  appear to come from a dummy of a person or animal.

Ventriloquist combines [Vagrant](http://www.vagrantup.com/) and [Docker](http://www.docker.io/)
to give **developers** the ability to configure portable and disposable development
environments with ease. It lowers the entry barrier of building a sane working environment
without the need to learn tools like [Puppet](http://puppetlabs.com/puppet/what-is-puppet)
or [Chef](http://www.opscode.com/chef/).

Its core is made of a Vagrant plugin that uses a set of opinionated Docker
images + some [guest capabilities](http://docs.vagrantup.com/v2/plugins/guest-capabilities.html)
to provision VMs with services, programming language environments and OS packages,
think of it as a "Heroku for Vagrant" where a Dyno is your Vagrant machine and Docker
services are its addons.

To give you an idea, this is what it takes to configure a Vagrant VM ready
for development on [Discourse](http://www.discourse.org/):

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "quantal64"
  config.vm.provision :ventriloquist do |env|
    env.services  << %w( redis-2.8 pg-9.1 mailcatcher-0.5 )
    env.platforms << %w( nodejs-0.10 ruby-1.9.3 )
  end
end
```


## Project Goals

* Multi purpose, "zero-conf" development environments that fits into a gist.
* Production parity for those that have no control of their production machines,
  like if you are deploying to Heroku or another PaaS.
* Be the easiest tool for building other tools development environments, for
  prototyping and also to give a head start to those introducing Vagrant / Docker
  to legacy projects.


## Installation

Make sure you have Vagrant 1.5+ and run:

```
vagrant plugin install ventriloquist
```


## Usage

Add the provisioner block to your Vagrantfile and `vagrant up` it:

```ruby
Vagrant.configure("2") do |config|
  config.vm.provision :ventriloquist do |env|
    # Pick the Docker version you want to use (defaults to 0.9.1)
    # or use :latest to install the latest version available
    env.docker_version = '0.9.1'

    # Pick the services you need to have around
    env.services << %w( redis-2.8 pg-9.1 memcached-1.4 elasticsearch-1.1 )

    # Configure your development environment
    env.platforms << %w( nodejs-0.10 ruby-2.0.0 go-1.2 )

    # Install random packages
    env.packages << %w( imagemagick htop sqlite3 )
  end
end
```

If you are using the plugin on a VirtualBox machine, you need to make sure the
VM has at least 1gb of RAM, so make sure you have something similar to the code
below on your `Vagrantfile`:

```ruby
Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end
end
```


## Available services

| Name              | Notes |
| ----------------- | ----- |
| elasticsearch-1.1 | Runs on port 9200 |
| memcached-1.4     | Runs on port 11211 |
| postgres-9.3      | Runs on port 5432 and adds an `export PGHOST=localhost` to the guest's `/etc/profile.d/ventriloquist`. It will also install the `postgresql-client` and `libpq-dev` packages on the guest. |
| postgres-9.2      | Same as above |
| postgres-9.1      | Same as above |
| mysql-5.6         | Runs on port 3306 and creates a `/home/vagrant/.my.conf`. It will also install the `mysql-client` and `libmysqlclient-dev` packages on the guest. |
| mysql-5.5         | Same as above |
| redis-2.8         | Runs on port 6379 and installs / compiles the `redis-cli` excutable |
| mailcatcher-0.5   | SMPT server runs on 1025 and web interface on 1080 |
| rethinkdb-1.12    | Uses the 28015 port for the client driver, 29015 for the intracluster connections and 8080 for the administrative web UI |

The `services` parameter passed in on the Vagrantfile are the ones built with the
Dockerfiles available under [_/services_](services) that are configured to require
no additional configuration for usage with the default `vagrant` user that usually
comes with Vagrant boxes. Apart from that they'll always be available from `localhost`
using the default service port (like 5432 for PostgreSQL).

Some extra steps might be required to simplify the connection with the configured
services. As an example, besides running the associated Docker image, setting up
PostgreSQL will involve installing the `postgresql-client` package and adding an
`export PGHOST=localhost` to the guest's `/etc/profiles.d/ventriloquist.sh` so that
the `psql` client works without any extra params.

Please note that all of the builtin images are available on the [Docker index](https://index.docker.io/)
with the `fgrehm/ventriloquist-` prefix that is ommited on the table above.

For fine grained control over how Ventriloquist runs images:

```ruby
Vagrant.configure("2") do |config|
  config.vm.provision :ventriloquist do |env|
    env.services << {
      redis:    { image: 'username/redis' },
      postgres: { image: 'otheruser/pg' }
    }

    # If you need more instances of a service, you'll need to give it a unique
    # name and fine tune it at will, for example:
    env.services << {
      # This is simple Vagrant Docker provisioner container
      api_db: { image: 'otheruser/postgres', args: '-p :5432' },

      # The 'vimage' saves you from typing in `image: 'fgrehm/ventriloquist-redis-2.8'`
      worker_redis: { vimage: 'redis-2.8', type: 'redis', args: '-P' },

      # The 'type' parameter tells Ventriloquist to configure the service with
      # its defaults and does some extra work (like installing additional packages)
      # if the service requires it
      worker_db: { image: 'your-user/your-pg', type: 'postgres' },
    }
  end
end
```

_See http://docs.vagrantup.com/v2/provisioning/docker.html for other arguments_


## Available platforms

| Name      | Notes             |
| --------- | ----------------- |
| ruby      | Uses rvm for installing rubies |
| go        | Downloads from https://code.google.com/p/go/downloads/list |
| nodejs    | Uses nvm for installing node versions |
| phantomjs | Downloads from https://bitbucket.org/ariya/phantomjs/downloads or https://code.google.com/p/phantomjs/downloads/list |
| erlang    | The latest version available at https://packages.erlang-solutions.com/erlang/ (currently R16B03-1) |
| elixir    | Downloads from https://github.com/elixir-lang/elixir/releases |
| python    | Uses pyenv for installing python versions |

In order to configure the VM for usage with the programming language that your
app is written on, the plugin leverages Vagrant's [guest capabilities](http://docs.vagrantup.com/v2/plugins/guest-capabilities.html)
to deal with distribution specifics. Right now things should work just fine on
Ubuntu VMs and you'll be warned in case you specify a something that is not supported
on your guest machine.

Platforms like `ruby`, `nodejs` and `python` also support installing multiple
versions since we rely on tools that take care of that for us:

```ruby
Vagrant.configure("2") do |config|
  config.vm.provision :ventriloquist do |env|
    env.platforms << {
      # The first version provided will be set as the default
      nodejs: { versions: ['0.10', '0.9']    },
      ruby:   { versions: ['2.1.1', '2.1.0'] }

      # The code above is the same as
      env.platforms << %w( nodejs-0.9 nodejs-0.10 ruby-2.1.1 ruby-2.1.0 )
    }
  end
end
```

_NOTICE: Previous versions of the plugin allowed users to omit the platform version
to be installed, but starting with 0.5.0 you need to set it explicitly on your
`Vagrantfile` (ex: `env.platforms << 'ruby'` becomes `env.platforms << 'ruby-2.1.1`)_


## System packages

There are times that you just want to install some random set of packages on the guest
machine and frequently you end up writing lots of inline shell scripts with
`apt-get update && apt-get install ...`s all over the place. In order to avoid those
long strings polluting your Vagrantfile you can use the `packages` parameter to save
you a few keystrokes.

In other words:

```ruby
Vagrant.configure("2") do |config|
  # This:
  config.vm.provision :shell, inline: %[
    apt-get update
    apt-get install -y --force-yes -q \
                    -o Dpkg::Options::='--force-confdef' \
                    -o Dpkg::Options::='--force-confold' \
                    htop sqlite3 curl lxc
  ]

  # Becomes this:
  config.vm.provision :ventriloquist do |env|
    env.packages << %w( htop sqlite3 curl lxc )
  end
end
```

Please note that once the package is instaled it won't ever be upgraded unless
you run a `apt-get upgrade` or the equivalent.

## Ideas for improvements

* Use a Docker container as the dev environment within the Vagrant VM, maybe using
  [Buildstep](https://github.com/progrium/buildstep) or something like it to
  configure it.
* Support for installing "random" tools / packages from within the Vagrantfile
  (like git / sqlite3 / heroku toolbelt / ruby gems / npm packages)


### Usage with [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)

If you are on a Linux machine and want to use vagrant-lxc you'll need to enable
container nesting by adding the code below to your Vagrantfile:

```ruby
Vagrant.configure("2") do |config|
  # vagrant-lxc specific tweaks for getting docker to run inside the container
  config.vm.provider :lxc do |lxc|
    lxc.customize 'aa_profile', 'unconfined'
  end
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
