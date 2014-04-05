module VagrantPlugins
  module Ventriloquist
    module Platforms
      class NodeJS < Platform
        def provision(machine)
          if @config[:versions].empty?
            machine.env.ui.warn('No nodejs version was specified and only nvm will be installed')
          end

          machine.guest.tap do |guest|
            guest.capability(:install_packages, 'curl', silent: true)
            guest.capability(:nvm_install)
            # Reverse array so that the first version specified is installed last
            # and gets set as the default
            @config[:versions].reverse.each do |version|
              guest.capability(:nvm_install_nodejs, version)
            end
          end
        end
      end
    end
  end
end
