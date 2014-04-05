module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Ruby < Platform
        def provision(machine)
          if @config[:versions].empty?
            machine.env.ui.warn('No ruby version was specified and only rvm will be installed')
          end

          machine.guest.tap do |guest|
            guest.capability(:install_packages, 'curl', silent: true)
            guest.capability(:rvm_install)
            # Reverse array so that the first version specified is installed last
            # and gets set as the default
            @config[:versions].reverse.each do |version|
              guest.capability(:rvm_install_ruby, version)
            end
          end
        end
      end
    end
  end
end
