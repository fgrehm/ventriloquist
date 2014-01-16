module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Elixir < Platform
        def provision(machine)
          @config[:version] = '0.12.2' if @config[:version] == 'latest'
          machine.guest.tap do |guest|
            guest.capability(:erlang_install)
            guest.capability(:elixir_install, @config[:version])
          end
        end
      end
    end
  end
end
