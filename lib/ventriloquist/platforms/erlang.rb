module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Erlang < Platform
        def provision(machine)
          machine.guest.capability(:erlang_install)
        end
      end
    end
  end
end
