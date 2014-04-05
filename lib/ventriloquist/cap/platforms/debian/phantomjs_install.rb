module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module PhantomjsInstall
          def self.phantomjs_install(machine, version)
            if machine.communicate.test('which phantomjs > /dev/null')
              machine.env.ui.info("Skipping phantomjs installation")
              return
            end

            src_1      = "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-#{version}-linux-x86_64.tar.bz2"
            src_2      = "https://phantomjs.googlecode.com/files/phantomjs-#{version}-linux-x86_64.tar.bz2"
            executable = "/usr/local/share/phantomjs-#{version}-linux-x86_64/bin/phantomjs"

            machine.env.ui.info("Installing phantomjs #{version}")
            machine.communicate.tap do |comm|
              comm.sudo('apt-get install -y fontconfig libfreetype6 curl -y -q')
              path = download_path(comm, version)
              unless comm.test("test -f #{path}")
                machine.guest.capability(:download, [src_1, src_2], path)
              end
              comm.sudo("tar xjfv #{path} -C /usr/local/share")
              comm.sudo("ln -s #{executable} /usr/local/bin/phantomjs")
            end
          end

          private

          def self.download_path(comm, version)
            # If vagrant-cachier cache buckets are available, drop it there
            if comm.test("test -d /tmp/vagrant-cache")
              "/tmp/vagrant-cache/phantomjs-#{version}.tar.bz2"
            else
              "/tmp/phantomjs-#{version}.tar.bz2"
            end
          end
        end
      end
    end
  end
end
