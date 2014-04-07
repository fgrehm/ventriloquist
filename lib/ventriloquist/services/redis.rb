module VagrantPlugins
  module Ventriloquist
    module Services
      class Redis < Service
        def initialize(*args)
          super
          @config[:args] ||= '-p 6379:6379'
        end

        def provision(machine)
          super
          install_client(machine)
        end

        protected

        def install_client(machine)
          return if machine.communicate.test('which redis-cli > /dev/null')

          redis_version = '2.8.8'
          machine.guest.tap do |guest|
            guest.capability(:install_build_tools)
            # TODO: Use the same version specified on the Vagrantfile
            guest.capability(:download, "http://download.redis.io/releases/redis-#{redis_version}.tar.gz", "/tmp/redis-#{redis_version}.tar.gz")
            guest.capability(:untar, "/tmp/redis-#{redis_version}.tar.gz", '/tmp')
            guest.capability(:make, "/tmp/redis-#{redis_version}", 'redis-cli')
          end

          machine.communicate.tap do |comm|
            comm.sudo("cp /tmp/redis-#{redis_version}/src/redis-cli /usr/local/bin")
            comm.execute('rm -rf /tmp/redis-*')
          end
        end
      end
    end
  end
end
