module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module Download
          def self.download(machine, src, destination)
            machine.communicate.tap do |comm|
              if comm.test('which wget')
                download_with_wget(machine, src, destination)

              elsif comm.test('which curl')
                download_with_curl(machine, src, destination)

              # If neither wget or curl could be found, try installing
              # curl
              elsif machine.capability?(:install_packages)
                machine.guest.capability(:install_packages, 'curl')
                download_with_curl(machine, src, destination)

              else
                raise 'Unable to download file for guest VM!'
              end
            end
          end

          def self.download_with_wget(machine, src, destination)
            machine.env.ui.info("Downloading #{src} to #{destination}")
            machine.communicate.execute("wget #{src} -O #{destination}")
          end

          def self.download_with_curl(machine, src, destination)
            machine.env.ui.info("Downloading #{src} to #{destination}")
            machine.communicate.execute("curl #{src} -o #{destination}")
          end
        end
      end
    end
  end
end
