module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module MySqlConfigureClient
          def self.mysql_configure_client(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('grep -q client $HOME/.my.cnf 2>/dev/null')
                machine.env.ui.info('Setting default MySQL configs')
                comm.execute('echo -e "[client]\nprotocol=tcp\npassword=vagrant" >> $HOME/.my.cnf')
              end
            end
          end
        end
      end
    end
  end
end
