module VagrantPlugins
  module Ventriloquist
    module Platforms
      class PhantomJS < Platform
        def provision(machine)
          if @config[:versions].empty?
            machine.env.ui.warn('No phantomjs version specified, skipping installation')
            return
          elsif @config[:versions].size > 1
            machine.env.ui.warn('Multiple versions specified for phantomjs, installing the first one configured')
          end
          machine.guest.capability(:phantomjs_install, @config[:versions].first)
        end
      end
    end
  end
end
