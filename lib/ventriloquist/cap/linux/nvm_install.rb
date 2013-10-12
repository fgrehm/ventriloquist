module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module NvmInstall
          def self.nvm_install(machine)
            if ! machine.communicate.test('test -d $HOME/.nvm')
              machine.env.ui.info('Installing NVM')
              machine.communicate.execute('\curl https://raw.github.com/creationix/nvm/master/install.sh | sh')
            end
          end
        end
      end
    end
  end
end
