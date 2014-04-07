module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module VentriloquistContainersUpstart
          def self.ventriloquist_containers_upstart(machine)
            machine.communicate.tap do |comm|
              if ! comm.test('test -f /etc/init/ventriloquist.conf')
                machine.env.ui.info('Configuring Ventriloquist services upstart')
                comm.sudo '
cat<<EOF > /etc/init/ventriloquist.conf
description "Restart configured Ventriloquist services after reboot"

start on started docker

task

script
  if [ -d /var/lib/ventriloquist/cids ]; then
    sleep 1 # Give Docker some time
    for cidfile in \$(ls /var/lib/ventriloquist/cids/*); do
      cid=\$(cat \$cidfile)
      if ! \$(docker ps | grep -q \$cid); then
        docker start \$(cat \$cidfile)
      else
        echo "Container \${cid} already started"
      fi
    done
  fi
end script
EOF'
              end
            end
          end
        end
      end
    end
  end
end
