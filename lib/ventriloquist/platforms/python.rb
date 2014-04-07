module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Python < Platform
        def provision(machine)
          if @config[:versions].empty?
            machine.env.ui.warn('No python version was specified and only pyenv will be installed')
          end

          machine.guest.tap do |guest|
            guest.capability(:pyenv_install)
            # Reverse array so that the first version specified is installed last
            # and gets set as the default
            @config[:versions].reverse.each do |version|
              guest.capability(:pyenv_install_python, version)
            end
          end
        end
      end
    end
  end
end
