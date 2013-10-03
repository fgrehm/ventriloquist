module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module ErlangInstall
          def self.erlang_install(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('which erlang > /dev/null')
                machine.env.ui.info('Installing Erlang')
                comm.execute('wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb')
                comm.sudo('dpkg -i erlang-solutions_1.0_all.deb')
                comm.sudo('apt-get update')
                comm.sudo('apt-get -y install erlang')
              end
            end
          end
        end
      end
    end
  end
end
