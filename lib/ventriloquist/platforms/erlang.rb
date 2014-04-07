module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Erlang < Platform
        def provision(machine)
          if ! @config[:versions].empty?
            machine.env.ui.warn('Multiple versions of erlang were specified but the latest one will be installed')
          end
          machine.guest.capability(:erlang_install)
        end
      end
    end
  end
end
