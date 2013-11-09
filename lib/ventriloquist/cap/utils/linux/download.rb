module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module Download
          # FIXME: Use vagrant downloader and upload to guest machine
          def self.download(machine, src, destination)
            machine.communicate.tap do |comm|
              if comm.test('which wget')
                machine.env.ui.info("Downloading #{src} to #{destination}")
                comm.execute("wget #{src} -O #{destination}")

              elsif comm.test('which curl')
                machine.env.ui.info("Downloading #{src} to #{destination}")
                comm.execute("curl #{src} -o #{destination}")

              else
                raise 'Unable to download file for guest VM!'
              end
            end
          end
        end
      end
    end
  end
end
