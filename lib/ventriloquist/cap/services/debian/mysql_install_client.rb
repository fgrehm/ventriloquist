module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module MySqlInstallClient
          def self.mysql_install_client(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('which mysql > /dev/null')
                machine.env.ui.info('Installing MySQL client')
                machine.guest.capability(:install_packages, 'mysql-client', silent: true)
              end
            end
          end
        end
      end
    end
  end
end
