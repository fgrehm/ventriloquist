module VagrantPlugins
  module Ventriloquist
    module Platforms
      class Elixir < Platform
        def provision(machine)
          if @config[:versions].empty?
            machine.env.ui.warn('No elixir version specified, skipping installation')
            return
          elsif @config[:versions].size > 1
            machine.env.ui.warn('Multiple versions specified for elixir, installing the first one configured')
          end
          machine.guest.tap do |guest|
            guest.capability(:erlang_install)
            guest.capability(:elixir_install, @config[:versions].first)
          end
        end
      end
    end
  end
end
