module VagrantPlugins
  module Ventriloquist
    module Services
      class Redis < Service
        def initialize(*args)
          super
          @config[:ports] ||= ['6379:6379']
        end

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
            # TODO: Use the same version specified on the Vagrantfile
            guest.capability(:download, 'http://download.redis.io/releases/redis-2.8.1.tar.gz', '/tmp/redis-2.8.0.tar.gz')
            guest.capability(:untar, '/tmp/redis-2.8.1.tar.gz', '/tmp')
            guest.capability(:make, '/tmp/redis-2.8.1', 'redis-cli')
          end

          machine.communicate.tap do |comm|
            comm.sudo('cp /tmp/redis-2.8.1/src/redis-cli /usr/local/bin')
            comm.execute('rm -rf /tmp/redis-*')
          end
        end
      end
    end
  end
end
