module VagrantPlugins
  module Ventriloquist
    module Platforms
      class PhantomJS < Platform
        def provision(machine)
          @config[:version] = '1.9.1' if config[:version] == 'latest'
          machine.guest.capability(:phantomjs_install, @config[:version])
        end
      end
    end
  end
end
