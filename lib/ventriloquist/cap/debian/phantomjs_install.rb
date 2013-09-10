module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module PhantomjsInstall
          def self.phantomjs_install(machine, version)
            return if machine.communicate.test('which phantomjs > /dev/null')

            version ||= '1.9.1'
            src        = "https://phantomjs.googlecode.com/files/phantomjs-#{version}-linux-x86_64.tar.bz2"
            executable = "/usr/local/share/phantomjs-#{version}-linux-x86_64/bin/phantomjs"

            machine.env.ui.info("Installing phantomjs #{version}")
            machine.communicate.tap do |comm|
              comm.sudo('apt-get install -y fontconfig libfreetype6 curl -y -q')
              # TODO: Use download + untar capability
              comm.execute("cd /usr/local/share && curl #{src} | sudo tar xjfv -")
              comm.sudo("ln -s #{executable} /usr/local/bin/phantomjs")
            end
          end
        end
      end
    end
  end
end
