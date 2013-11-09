module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module InstallPackages
          def self.install_packages(machine, packages, opts = {})
            packages = Array(packages).flatten
            machine.communicate.tap do |comm|
              # Based on http://askubuntu.com/a/17829
              packages_to_install = packages - installed_packages(machine)
              return if packages_to_install.empty?

              unless opts[:silent]
                machine.env.ui.info("Installing #{packages_to_install}")
              end

              if requires_update?(machine)
                puts 'apt-get update!'
                comm.sudo("apt-get update -q")
              end
              comm.sudo("apt-get install #{packages_to_install.join(' ')} -y --force-yes -q -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'")
            end
          end

          def self.installed_packages(machine)
            pkgs = ""
            cmd  = "dpkg --get-selections | grep -v deinstall | awk '{ print $1 }'"
            machine.communicate.execute cmd do |buffer, output|
              if buffer == :stdout
                pkgs << output.chomp
              end
            end
            pkgs.split("\n")
          end

          def self.requires_update?(machine)
            @@_updated_machines ||= {}

            required = !@@_updated_machines[machine]
            @@_updated_machines[machine] = true

            return required
          end
        end
      end
    end
  end
end
