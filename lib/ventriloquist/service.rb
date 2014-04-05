module VagrantPlugins
  module Ventriloquist
    class Service
      CONTAINER_IDS_PATH = '/var/lib/ventriloquist/cids'

      attr_reader :name, :config, :docker_client

      def initialize(name, config, docker_client)
        @name, @config, @docker_client = name, config, docker_client
      end

      def provision(machine)
        cidfile = "#{CONTAINER_IDS_PATH}/#{@name}"

        if @docker_client.container_running?("$(cat #{cidfile})")
          machine.env.ui.info("Service '#{@name}' already running")
        else
          machine.env.ui.info("Starting '#{@name}' service")
          machine.communicate.sudo("mkdir -p #{CONTAINER_IDS_PATH}")
          @config[:cidfile]          = cidfile
          @config[:daemonize]        = true
          @config[:name]             = @name
          @config[:auto_assign_name] = false
          @docker_client.run_container(@config)
        end
      end
    end
  end
end
