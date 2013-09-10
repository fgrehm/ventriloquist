module VagrantPlugins
  module Ventriloquist
    module Platforms
      class NodeJS < Platform
        def provision(machine)
          machine.guest.capability(:nodejs_install)
        end
      end
    end
  end
end
