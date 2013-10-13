module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module RvmInstall
          def self.rvm_install(machine)
            if ! machine.communicate.test('test -d $HOME/.rvm')
              machine.env.ui.info('Installing RVM')
              machine.communicate.execute('\curl -L https://get.rvm.io | bash -s stable --autolibs=enabled')
              #machine.communicate.execute('rvm requirements')
            end
          end
        end
      end
    end
  end
end
