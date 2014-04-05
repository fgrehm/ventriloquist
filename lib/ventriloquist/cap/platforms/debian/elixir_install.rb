module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module ElixirInstall
          ELIXIR_PRECOMPILED_1 = "https://github.com/elixir-lang/elixir/releases/download/vVERSION/Precompiled.zip"
          ELIXIR_PRECOMPILED_2 = "https://github.com/elixir-lang/elixir/releases/download/vVERSION/vVERSION.zip"

          def self.elixir_install(machine,version)
            @version = version

            machine.communicate.tap do |comm|
              if ! comm.test('which iex > /dev/null')
                bin_path = "/usr/local/elixir/bin"
                srcs = [
                  ELIXIR_PRECOMPILED_1.gsub(/VERSION/, @version),
                  ELIXIR_PRECOMPILED_2.gsub(/VERSION/, @version)
                ]

                machine.env.ui.info("Installing Elixir #{@version}")

                path = download_path(comm)

                unless comm.test("test -f #{path}")
                  machine.guest.capability(:download, srcs, path)
                end

                # TODO: Create unzip capability
                comm.sudo('apt-get install -y unzip')
                comm.sudo("unzip -o #{path} -d /usr/local/elixir")

                if ! comm.test("grep -q '#{bin_path}' /etc/profile.d/ventriloquist.sh 2>/dev/null")
                  comm.sudo("echo 'export PATH=$PATH:#{bin_path}' >> /etc/profile.d/ventriloquist.sh")
                end
              end
            end
          end

          private

          def self.download_path(comm)
            # If vagrant-cachier cache bucket are available, drop it there
            if comm.test("test -d /tmp/vagrant-cache")
              "/tmp/vagrant-cache/elixir-v#{@version}.zip"
            else
              "/tmp/elixir-v#{@version}.zip"
            end
          end
        end
      end
    end
  end
end
