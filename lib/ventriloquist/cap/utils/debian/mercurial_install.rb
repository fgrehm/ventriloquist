module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module MercurialInstall
          def self.mercurial_install(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('which hg > /dev/null')
                machine.env.ui.info('Installing mercurial')
                comm.sudo('apt-get install -y mercurial')
              end
            end
          end
        end
      end
    end
  end
end
