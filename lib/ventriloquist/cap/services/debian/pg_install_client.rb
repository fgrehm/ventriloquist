module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module PgInstallClient
          def self.pg_install_client(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('which psql > /dev/null')
                machine.env.ui.info('Installing PostgreSQL client')
                machine.guest.capability(:install_packages, 'postgresql-client', silent: true)
              end
            end
          end
        end
      end
    end
  end
end
