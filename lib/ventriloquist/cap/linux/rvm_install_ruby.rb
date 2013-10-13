module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module RvmInstallRuby
          def self.rvm_install_ruby(machine, version)
            if ! machine.communicate.test("rvm list | grep #{version}")
              machine.env.ui.info("Installing Ruby #{version}")
              machine.communicate.sudo("rvm install #{version}")
              # FIXME: THIS IS DEBIAN SPECIFIC
              machine.communicate.sudo("apt-get install -y libxslt1-dev")
            end
          end
        end
      end
    end
  end
end
