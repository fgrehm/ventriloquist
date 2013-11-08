module VagrantPlugins
  module Ventriloquist
    module Services
      class MySql < Service
        def initialize(*args)
          super
          @config[:ports] ||= ['3306:3306']
        end

        def provision(machine)
          super

          @machine = machine

          install_client
          install_headers
          configure_client
        end

        protected

        def install_client
          if @machine.guest.capability?(:mysql_install_client)
            @machine.guest.capability(:mysql_install_client)
          else
            @machine.env.ui.warn 'Unable to install the MySQL client'
          end
        end

        def install_headers
          if @machine.guest.capability?(:mysql_install_headers)
            @machine.guest.capability(:mysql_install_headers)
          else
            @machine.env.ui.warn 'Unable to install MySQL header files'
          end
        end

        def configure_client
          @machine.guest.capability(:mysql_configure_client)
        end
      end
    end
  end
end
