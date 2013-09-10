module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module PgExportPghost
          def self.pg_export_pghost(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('grep -q PGHOST /etc/profile.d/ventriloquist.sh 2>/dev/null')
                machine.env.ui.info('Setting default PGHOST')
                comm.sudo('echo "export PGHOST=localhost" >> /etc/profile.d/ventriloquist.sh')
              end
            end
          end
        end
      end
    end
  end
end
