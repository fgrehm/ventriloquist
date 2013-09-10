module VagrantPlugins
  module Ventriloquist
    class Service
      CONTAINER_IDS_PATH = '/var/lib/ventriloquist/cids'

      attr_reader :name, :config, :docker_client

      def initialize(name, config, docker_client)
        @name, @config, @docker_client = name, config, docker_client
      end

      def provision(machine)
        machine.env.ui.info("Starting #{@name} service")
        machine.communicate.sudo("mkdir -p #{CONTAINER_IDS_PATH}")
        # Reduce network latency, see https://groups.google.com/d/msg/docker-user/Z3zQuRawIsE/2AEkl30WpTQJ
        # for more info
        @config[:dns]     = '127.0.0.1'
        @config[:cidfile] = "#{CONTAINER_IDS_PATH}/#{@name}"
        @docker_client.run_container(@config)
      end
    end
  end
end
