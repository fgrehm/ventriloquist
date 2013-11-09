module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Ruby < Platform
        def provision(machine)
          @config[:version] = '2.0.0' if @config[:version] == 'latest'
          machine.guest.tap do |guest|
            guest.capability(:install_packages, 'curl', silent: true)
            guest.capability(:rvm_install)
            guest.capability(:rvm_install_ruby, @config[:version])
          end
        end
      end
    end
  end
end
