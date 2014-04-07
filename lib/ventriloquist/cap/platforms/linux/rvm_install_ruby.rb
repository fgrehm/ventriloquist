module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module RvmInstallRuby
          def self.rvm_install_ruby(machine, version)
            if ! machine.communicate.test("rvm list | grep #{version}")
              machine.env.ui.info("Installing Ruby #{version}")
              machine.communicate.sudo("rvm install #{version}")
              machine.guest.capability(:install_packages, 'libxslt1-dev', silent: true)
            else
              machine.env.ui.info("Skipping Ruby #{version} installation")
            end
          end
        end
      end
    end
  end
end
