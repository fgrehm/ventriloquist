module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Python < Platform
        def provision(machine)
          @config[:version] = '3.3.2' if @config[:version] == 'latest'
          machine.guest.tap do |guest|
            guest.capability(:pyenv_install)
            guest.capability(:pyenv_install_python, @config[:version])
          end
        end
      end
    end
  end
end
