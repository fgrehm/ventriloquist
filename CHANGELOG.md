## [0.4.0](https://github.com/fgrehm/ventriloquist/compare/v0.3.2...master) (unreleased)

FEATURES:

  - Added support for using RethinkDB [[GH-4]]
  - Support for installing guest specific packages (aka `apt-get install`)
  - Introduce `:type` and `:vimage` parameters for services allowing us to provision
    multiple containers of the same kind with less pain.
  - Docker containers are now named after the services configured on the Vagrantfile

BACKWARDS INCOMPATIBILITY:

  - The Docker images that make up for services no longer exposes host ports by
    default in order to aling with Docker's [recent changes](http://blog.docker.io/2013/10/docker-0-6-5-links-container-naming-advanced-port-redirects-host-integration)
    related to the way exposed ports work.

IMPROVEMENTS:

  - core: Bumped [[vocker]] dependency to 0.4.0
  - core: Provide feedback during provisioning whether a service is already running
  - platforms/elixir: Bumped to 0.11.1 [[GH-34]]
  - platforms/phantomjs: Bumped to 1.9.2
  - platforms/rvm: Install globally [[GH-24]]
  - services/elasticsearch: Bumped to 0.90.6
  - services: Most images had the `RUN` instructions inlined in order to reduce the amount
    of AUFS layers

## [0.3.2](https://github.com/fgrehm/ventriloquist/compare/v0.3.1...v0.3.2) (October 28, 2013)

BUG FIXES:

  - Properly escape upstart job parameters

## [0.3.1](https://github.com/fgrehm/ventriloquist/compare/v0.3.0...v0.3.1) (October 27, 2013)

BUG FIXES:

  - Prevent upstart job from respawning all the time and fix issues related to
    stopping containers [[GH-9]]


## [0.3.0](https://github.com/fgrehm/ventriloquist/compare/v0.2.1...v0.3.0) (October 23, 2013)

FEATURES:

  - Elixir support [[GH-3]]
  - Python support [[GH-19]]

IMPROVEMENTS:

  - Bump [[vocker]] dependency to 0.3.2

## [0.2.1](https://github.com/fgrehm/ventriloquist/compare/v0.2.0...v0.2.1) (October 12, 2013)

FEATURES:

  - Make use of nvm for when installing nodejs, allowing installation of any nodejs version
    instead of what's available at https://launchpad.net/~chris-lea/+archive/node.js [[GH-22]]

## [0.2.0](https://github.com/fgrehm/ventriloquist/compare/v0.1.0...v0.2.0) (October 3, 2013)

FEATURES:

  - Erlang support [[GH-12]]
  - MailCatcher service [[GH-8]]

BUG FIXES:

  - Bump dependency on Vocker to ~> 0.3.1 in order to fix errors when trying to
    provision a machine that already have a service / container running.

## 0.1.0 (September 10, 2013)

  - Initial public release.



[GH-34]: https://github.com/fgrehm/ventriloquist/issues/24
[GH-24]: https://github.com/fgrehm/ventriloquist/issues/24
[GH-9]: https://github.com/fgrehm/ventriloquist/issues/9
[GH-19]: https://github.com/fgrehm/ventriloquist/issues/19
[GH-3]: https://github.com/fgrehm/ventriloquist/issues/3
[GH-22]: https://github.com/fgrehm/ventriloquist/issues/22
[GH-12]: https://github.com/fgrehm/ventriloquist/issues/12
[GH-8]: https://github.com/fgrehm/ventriloquist/issues/8
[vocker]: https://github.com/fgrehm/vocker
