module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module NvmInstallNodeJS
          def self.nvm_install_nodejs(machine, version)
            if ! machine.communicate.test("nvm ls | grep #{version}")
              machine.env.ui.info("Installing NodeJS #{version}")
              machine.communicate.execute("nvm install #{version}")
              machine.communicate.execute("nvm alias default #{version}")
            end
          end
        end
      end
    end
  end
end
