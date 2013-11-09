module VagrantPlugins
  module Ventriloquist
    module Cap
      module Debian
        module MercurialInstall
          def self.mercurial_install(machine)
            machine.guest.capability(:install_packages, 'mercurial')
          end
        end
      end
    end
  end
end
