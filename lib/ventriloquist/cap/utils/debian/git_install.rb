module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module GitInstall
          def self.git_install(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('which git > /dev/null')
                machine.env.ui.info('Installing git')
                comm.sudo('apt-get install -y git')
              end
            end
          end
        end
      end
    end
  end
end
