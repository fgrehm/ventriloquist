module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Go < Platform
        def provision(machine)
          @config[:version] = '1.2' if @config[:version] == 'latest'
          machine.guest.capability(:mercurial_install)
          machine.guest.capability(:go_install, @config[:version])
        end
      end
    end
  end
end
