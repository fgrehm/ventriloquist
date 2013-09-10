module VagrantPlugins
  module Ventriloquist
    module Services
      class Redis < Service
        def provision(machine)
          super
          install_client(machine)
        end

        protected

        # TODO: Use the same version as the configured service
        def install_client(machine)
          return if machine.communicate.test('which redis-cli > /dev/null')

          machine.guest.tap do |guest|
            guest.capability(:install_build_tools)
            guest.capability(:download, 'http://download.redis.io/redis-stable.tar.gz', '/tmp/redis-stable.tar.gz')
            guest.capability(:untar, '/tmp/redis-stable.tar.gz', '/tmp')
            guest.capability(:make, '/tmp/redis-stable', 'redis-cli')
          end

          machine.communicate.tap do |comm|
            comm.sudo('cp /tmp/redis-stable/src/redis-cli /usr/local/bin')
            comm.execute('rm -rf /tmp/redis-stable*')
          end
        end
      end
    end
  end
end
