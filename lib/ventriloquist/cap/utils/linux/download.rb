module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module Download
          def self.download(machine, srcs, destination)
            machine.communicate.tap do |comm|
              if comm.test('which wget')
                download_with_wget(machine, srcs, destination)

              elsif comm.test('which curl')
                download_with_curl(machine, srcs, destination)

              # If neither wget or curl could be found, try installing
              # curl
              elsif machine.capability?(:install_packages)
                machine.guest.capability(:install_packages, 'curl')
                download_with_curl(machine, srcs, destination)

              else
                raise 'Unable to download file for guest VM!'
              end
            end
          end

          def self.download_with_wget(machine, srcs, destination)
            Array(srcs).each_with_index do |src, idx|
              machine.env.ui.info("Attempting to download '#{src}' to '#{destination}'")
              begin
                machine.communicate.execute("wget #{src} -O #{destination} || { rm -f #{destination} && exit 1; }")
                break
              rescue Vagrant::Errors::VagrantError => e
                raise if idx + 1 == srcs.size
              end
            end
          end

          def self.download_with_curl(machine, srcs, destination)
            Array(srcs).each_with_index do |src, idx|
              machine.env.ui.info("Attempting to download '#{src}' to '#{destination}'")
              begin
                machine.communicate.execute("curl #{src} -o #{destination} || { rm -f #{destination} && exit 1; }")
                break
              rescue Vagrant::Errors::VagrantError => e
                raise if idx + 1 == srcs.size
              end
            end
          end
        end
      end
    end
  end
end
