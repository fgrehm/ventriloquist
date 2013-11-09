module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module InstallBuildTools
          def self.install_build_tools(machine)
            machine.guest.capability(:install_packages, 'build-essential')
          end
        end
      end
    end
  end
end
