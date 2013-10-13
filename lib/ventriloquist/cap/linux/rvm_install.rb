module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module RvmInstall
          def self.rvm_install(machine)
            if ! machine.communicate.test('test -d $HOME/.rvm')
              machine.env.ui.info('Installing RVM')
              machine.communicate.execute('\curl -L https://get.rvm.io | bash -s stable --autolibs=enabled --ignore-dotfiles')
              machine.communicate.execute("echo 'source $HOME/.rvm/scripts/rvm' >> ~/.profile")
            end
          end
        end
      end
    end
  end
end
