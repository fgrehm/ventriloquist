module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module Python
          def self.pyenv_install(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('test -d $HOME/.pyenv')
                machine.env.ui.info('Installing pyenv dependencies')
                comm.sudo('sudo apt-get install -y build-essential libreadline-dev libssl-dev libsqlite3-dev libbz2-dev')

                machine.env.ui.info('Installing pyenv')
                comm.execute <<-INSTALL
                  git clone git://github.com/yyuu/pyenv.git $HOME/.pyenv
                  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
                  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
                  echo 'eval "$(pyenv init -)"' >> ~/.profile
                INSTALL
              end
            end
          end

          def self.pyenv_install_python(machine, version)
            if ! machine.communicate.test("pyenv versions | grep #{version}")
              machine.env.ui.info("Installing Python #{version}")
              machine.communicate.execute("pyenv install #{version}")
              machine.communicate.execute("pyenv global #{version}")
            end
          end
        end
      end
    end
  end
end
