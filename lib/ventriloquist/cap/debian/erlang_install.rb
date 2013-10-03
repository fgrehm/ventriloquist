module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module ErlangInstall
          ERLANG_SOLUTIONS_PKG = "https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb"

          def self.erlang_install(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('which erlang > /dev/null')
                machine.env.ui.info('Installing Erlang')

                path = download_path(comm)
                unless comm.test("test -f #{path}")
                  machine.guest.capability(:download, ERLANG_SOLUTIONS_PKG, path)
                end
                comm.sudo("dpkg -i #{path}")

                comm.sudo('apt-get update')
                comm.sudo('apt-get -y install erlang')
              end
            end
          end

          private

          def self.download_path(comm)
            # If vagrant-cachier apt cache bucket is available, drop it there
            if comm.test("test -d /tmp/vagrant-cache/apt")
              "/tmp/vagrant-cache/apt/erlang-solutions_1.0_all.deb"
            else
              "/tmp/erlang-solutions_1.0_all.deb"
            end
          end
        end
      end
    end
  end
end
