module VagrantPlugins
  module Ventriloquist
    module Platforms
      class PhantomJS < Platform
        def provision(machine)
          machine.guest.capability(:phantomjs_install, @config[:version])
        end
      end
    end
  end
end
