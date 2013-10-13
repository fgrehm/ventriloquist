module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module RvmInstall
          def self.rvm_install(machine)
            if ! machine.communicate.test('test -d /usr/local/rvm')
              machine.env.ui.info('Installing RVM')
              machine.communicate.sudo('\curl -L https://get.rvm.io | bash -s stable --autolibs=enabled')
              machine.communicate.sudo('usermod -a -G rvm vagrant')
            end
          end
        end
      end
    end
  end
end
