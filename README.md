# Ventriloquist

> **ven·tril·o·quist**: _(noun)_ a person who can speak or utter sounds so that
  they seem to come from somewhere else, esp. an entertainer who makes their voice
  appear to come from a dummy of a person or animal.

Ventriloquist combines [Vagrant](http://www.vagrantup.com/) and [Docker](http://www.docker.io/)
to give **developers** the ability to configure portable and disposable development
VMs with ease. It lowers the entry barrier of building a sane working environment without
the need to learn tools like [Puppet](http://puppetlabs.com/puppet/what-is-puppet)
or [Chef](http://www.opscode.com/chef/).

Its core is made of a Vagrant plugin that uses a set of opinionated Docker
images + some [guest capabilities](http://docs.vagrantup.com/v2/plugins/guest-capabilities.html)
to provision VMs with services and programming language environments, think of
it as a "Heroku for Vagrant" where a Dyno is your Vagrant machine and Docker
services are its addons.

To give you an idea, this is what it takes to configure a Vagrant VM ready
for development on [Discourse](http://www.discourse.org/):

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "quantal64"
  config.vm.provision :ventriloquist do |env|
    env.services  << %w( redis pg:9.1 mailcatcher )
    env.platforms << %w( nodejs ruby:1.9.3 )
  end
end
```


## Project Goals

* Multi purpose, "zero-conf" development environments that fits into a gist.
* Production parity for those that have no control of their production machines,
  like if you are deploying to Heroku or another PaaS.
* Be the easiest tool for building other tools development environments.
* Be a learning playground for hackers, making it easy to learn new programming
  languages / tools.



## Status

Early development, the feature set and configuration format might change rapidly
and has only been tested on the following Ubuntu 13.04 Vagrant VMs using Docker
0.6.1 and Vagrant 1.2.7 / 1.3.0:

* http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box
* http://bit.ly/vagrant-lxc-raring64-2013-07-12 (yes! LXC inception :)

_Please note that in order to use the plugin on [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)
containers you need some extra steps described below_

On its current state is an "stable experiment", I've been using a setup with the
plugin without issues for more than a week now.



## Installation

Make sure you have Vagrant 1.2+ and run:

```
vagrant plugin install ventriloquist
```


## Usage

Just add the provisioner block to your Vagrantfile and `vagrant up` it:

```ruby
Vagrant.configure("2") do |config|
  config.vm.provision :ventriloquist do |env|
    # Pick the services you need to have around
    env.services << %w( redis pg:9.1 memcached elasticsearch )
    # Configure your development environment
    env.platforms << %w( nodejs ruby:2.0.0 go )
  end
end
```


## Available services

The `services` parameter passed in on the Vagrantfile are the ones built with the
Dockerfiles available under [_/services_](services) that are configured to require
no additional configuration for usage with the default `vagrant` user that usually
comes with Vagrant boxes and will always be available from `localhost` using the
default service port (like 5432 for PostgreSQL).

Some extra steps might be required to simplify the connection with the configured
services. As an example, besides running the associated Docker image, setting up
PostgreSQL will involve installing the `postgresql-client` package and adding an
`export PGHOST=localhost` to the guest's `/etc/profiles.d/ventriloquist.sh` so that
the `psql` client works without any extra params.

Please note that all of the builtin images are available on the [Docker index](https://index.docker.io/)
with the `fgrehm/ventriloquist-` prefix that is ommited on the table below:

| Name          | Provides       | Notes |
| ------------- | -------------- | ----- |
| elasticsearch | 0.90.3         | Runs on port 9200 |
| memcached     | 1.4.14         | Runs on port 11211 |
| pg            | PostgreSQL 9.2 | Runs on port 5432 and adds an `export PGHOST=localhost` to the guest's `/etc/profile.d/ventriloquist`. It will also install the `postgresql-client` and `libpq-dev` packages on the guest. |
| pg:9.1        | PostgreSQL 9.1 | Same as above |
| mysql         | 5.5            | Runs on port 3306 and creates a `/home/vagrant/.my.conf`. It will also install the `mysql-client` and `libmysqlclient-dev` packages on the guest. |
| redis         | 2.4.15         | Runs on port 6379 and installs / compiles the `redis-cli` excutable |
| mailcatcher   | 0.5.12         | SMPT server runs on 1025 and web interface on 1080 |
| solr          | 4.4.0          | Runs on port 8983 |

Since services are just Docker images, you can build your own image, push to the
registry and use it on your Vagrantfile, you'll just need to specify its fully
qualified name and the corresponding Ventriloquist service:

```ruby
Vagrant.configure("2") do |config|
  config.vm.provision :ventriloquist do |env|
    env.services << {
      redis: { image: 'username/redis' },
      pg:    { image: 'otheruser/pg', tag: 'latest' }
    }
  end
end
```


## Available platforms

In order to configure the VM for usage with the programming language that your
app is written on, the plugin leverages Vagrant's [guest capabilities](http://docs.vagrantup.com/v2/plugins/guest-capabilities.html)
to deal with distribution specifics. Right now things should work just fine on
Ubuntu VMs and you'll be warned in case you specify a something that is not supported
on your guest machine.

Unless you specify the version to use (like in `ruby:1.9.3` from the Discourse
example above), the latest version of the available platforms will be installed.
For example, if you omit the Ruby version you want to use, Ventriloquist will
install 2.0.0 with the latest path level.

So far I've only set up the stuff I need to work but feel free to submit a Pull
Request with the scripts required to set things for other platforms:

| Name      | Provides         |
| --------- | ---------------- |
| ruby      | rvm + Ruby 2.0.0 |
| go        | 1.1.2            |
| nodejs    | Currently limited to the latest version available at https://launchpad.net/~chris-lea/+archive/node.js (0.10.17 as of this writing) |
| phantomjs | 1.9.1            |


## Ideas for improvements

* Use a Docker container as the dev environment within the Vagrant VM, maybe using
  [Buildstep](https://github.com/progrium/buildstep) or something like it to
  configure it.
* Allow services configuration from the Vagrantfile (like setting the max memory
  used by memcached for example)
* Saner defaults for services (none of the provided services have memory / connection
  limits or the like)
* Make use of Docker data volumes for services to avoid loosing data
* Introduce "profiles" - `heroku:free` for example would limit postgresql / memcached
  / etc resources (like max memory / connections) to what people will get there.
* Support for installing "random" tools / packages from within the Vagrantfile
  (like git / sqlite3 / heroku toolbelt / ruby gems / npm packages)
* Leverage [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) during
  provisioning
* Convert provisioning code to a set of bash scripts so that it can be reused
  outside of Vagrant environments as well (maybe use them for building [Packer](http://www.packer.io/)
  images)


### Usage with [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc)

If you are on a Linux machine, you can use vagrant-lxc to avoid messing up with
your working environment. While developing this plugin I was able to recreate
containers that were capable of using Docker without issues multiple times on
an up to date Ubuntu 13.04 host and guest.

In order to allow a vagrant-lxc container to boot nested Docker containers you'll
just need to `apt-get install apparmor-utils && aa-complain /usr/bin/lxc-start`
and add the code below to your Vagrantfile:

```ruby
Vagrant.configure("2") do |config|
  config.vm.provider :lxc do |lxc|
    lxc.customize 'aa_profile', 'unconfined'
  end

  config.vm.provision :shell, inline: %[
    if ! [ -f /etc/default/lxc ]; then
      cat <<STR > /etc/default/lxc
LXC_AUTO="false"
USE_LXC_BRIDGE="false"
STR
    fi
  ]
end
```

The LXC networking configs are only required if you are on an Ubuntu host as
it automatically creates the `lxcbr0` bridge for you on the host machine and
if you don't do that the vagrant-lxc container will end up crashing as it
will collide with the host's `lxcbr0`.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
