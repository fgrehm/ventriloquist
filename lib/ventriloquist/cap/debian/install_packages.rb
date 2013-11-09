module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module InstallPackages
          def self.install_packages(machine, packages)
            machine.communicate.tap do |comm|
              # Based on http://askubuntu.com/a/17829
              packages_to_install = packages - installed_packages(machine)
              return if packages_to_install.empty?

              machine.env.ui.info("Installing #{packages_to_install}")
              comm.sudo("sudo apt-get install #{packages_to_install.join(' ')} -y --force-yes -q -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'")
            end
          end

          def self.installed_packages(machine)
            cmd = "dpkg --get-selections | grep -v deinstall | awk '{ print $1 }'"
            machine.communicate.execute cmd do |buffer, output|
              if buffer == :stdout
                return output.chomp.split("\n")
              end
            end
          end
        end
      end
    end
  end
end
