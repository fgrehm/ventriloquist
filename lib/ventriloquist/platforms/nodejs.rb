module VagrantPlugins
  module Ventriloquist
    module Platforms
      class NodeJS < Platform
        def provision(machine)
          @config[:version] = '0.10' if @config[:version] == 'latest'
          machine.guest.tap do |guest|
            guest.capability(:install_packages, 'curl', silent: true)
            guest.capability(:nvm_install)
            guest.capability(:nvm_install_nodejs, @config[:version])
          end
        end
      end
    end
  end
end
