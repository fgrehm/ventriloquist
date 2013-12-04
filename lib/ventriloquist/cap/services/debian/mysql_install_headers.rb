module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module MySqlInstallHeaders
          def self.mysql_install_headers(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('dpkg -l | grep libmysqlclient-dev')
                machine.env.ui.info('Installing MySQL headers')
                machine.guest.capability(:install_packages, 'libmysqlclient-dev', silent: true)
              end
            end
          end
        end
      end
    end
  end
end
