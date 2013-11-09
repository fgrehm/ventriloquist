module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module GitInstall
          def self.git_install(machine)
            machine.guest.capability(:install_packages, 'git')
          end
        end
      end
    end
  end
end
