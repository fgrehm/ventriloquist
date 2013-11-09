module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module InstallBuildTools
          def self.install_build_tools(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('dpkg -l | grep build-essential')
                machine.env.ui.info('Installing build tools')
                comm.sudo('apt-get install -y build-essential')
              end
            end
          end
        end
      end
    end
  end
end
