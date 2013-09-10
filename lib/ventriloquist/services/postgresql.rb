module VagrantPlugins
  module Ventriloquist
    module Services
      class PostgreSQL < Service
        def provision(machine)
          super

          @machine = machine

          install_client
          install_headers
          export_host
        end

        protected

        def install_client
          if @machine.guest.capability?(:pg_install_client)
            @machine.guest.capability(:pg_install_client)
          else
            @machine.env.ui.warn 'Unable to install the PostgreSQL client'
          end
        end

        def install_headers
          if @machine.guest.capability?(:pg_install_headers)
            @machine.guest.capability(:pg_install_headers)
          else
            @machine.env.ui.warn 'Unable to install PostgreSQL header files'
          end
        end

        def export_host
          @machine.guest.capability(:pg_export_pghost)
        end
      end
    end
  end
end
