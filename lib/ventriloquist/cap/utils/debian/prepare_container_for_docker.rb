module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module PrepareContainerForDocker
          def self.prepare_container_for_docker(machine)
            machine.communicate.tap do |comm|
              # Disable the default lxc bridge to prevent issues when starting the container
              if ! comm.test('test -f /etc/default/lxc')
                comm.sudo '
cat <<STR > /etc/default/lxc
LXC_AUTO="false"
USE_LXC_BRIDGE="false"
STR
apt-get update && \
apt-get install -y --force-yes lxc \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold"'
              end

              # Switch to lxc execution driver as wasn't able to get libcontainer to work
              if ! comm.test('$(grep -q "-e lxc" /etc/default/docker)')
                comm.sudo '
cat <<STR >> /etc/default/docker
DOCKER_OPTS="-e lxc ${DOCKER_OPTS}"
STR
service docker restart && sleep 5'
              end
            end
          end
        end
      end
    end
  end
end
