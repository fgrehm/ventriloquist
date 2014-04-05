module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module GoInstall
          def self.go_install(machine, version)
            return if machine.communicate.test('which go > /dev/null')

            src      = "https://go.googlecode.com/files/go#{version}.linux-amd64.tar.gz"
            bin_path = "/usr/local/go/bin"
            go_path  = "$HOME/go"

            machine.env.ui.info("Installing go #{version}")
            machine.communicate.tap do |comm|
              comm.sudo('apt-get install curl -y -q')
              path = download_path(comm, version)
              unless comm.test("test -f #{path}")
                machine.guest.capability(:download, src, path)
              end
              comm.sudo("tar xzfv #{path} -C /usr/local")

              if ! comm.test("grep -q '#{bin_path}' /etc/profile.d/ventriloquist.sh 2>/dev/null")
                comm.sudo("echo 'export PATH=$PATH:#{bin_path}' >> /etc/profile.d/ventriloquist.sh")
              end

              comm.execute("mkdir -p #{go_path}") if ! comm.test("test -d #{go_path}")

              if ! comm.test("grep -q '#{go_path}' /etc/profile.d/ventriloquist.sh 2>/dev/null")
                comm.sudo("echo 'export GOPATH=#{go_path}' >> /etc/profile.d/ventriloquist.sh")
              end
            end
          end

          def self.download_path(comm, version)
            # If vagrant-cachier cache buckets are available, drop it there
            if comm.test("test -d /tmp/vagrant-cache")
              "/tmp/vagrant-cache/go-#{version}.tar.gz"
            else
              "/tmp/go-#{version}.tar.gz"
            end
          end
        end
      end
    end
  end
end
