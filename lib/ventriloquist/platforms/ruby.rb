module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Ruby < Platform
        def provision(machine)
          machine.guest.tap do |guest|
            guest.capability(:rvm_install)
            guest.capability(:rvm_install_ruby, @config[:version])
          end
        end
      end
    end
  end
end
