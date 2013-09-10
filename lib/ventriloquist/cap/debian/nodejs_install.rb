module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module NodejsInstall
          def self.nodejs_install(machine)
            return if machine.communicate.test('which nodejs > /dev/null')

            machine.env.ui.info('Installing nodejs')
            machine.communicate.tap do |comm|
              comm.sudo('apt-get install -y software-properties-common')
              comm.sudo('add-apt-repository -y ppa:chris-lea/node.js')
              comm.sudo('apt-get update')
              comm.sudo("apt-get install -y nodejs")
            end
          end
        end
      end
    end
  end
end
