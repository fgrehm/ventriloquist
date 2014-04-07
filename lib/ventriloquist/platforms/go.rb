module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Go < Platform
        def provision(machine)
          if @config[:versions].empty?
            machine.env.ui.warn('No golang version specified, skipping installation')
            return
          elsif @config[:versions].size > 1
            machine.env.ui.warn('Multiple versions specified for golang, installing the first one configured')
          end
          machine.guest.capability(:mercurial_install)
          machine.guest.capability(:go_install, @config[:versions].first)
        end
      end
    end
  end
end
