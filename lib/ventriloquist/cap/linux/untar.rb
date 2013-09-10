module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module Untar
          def self.untar(machine, src, workdir)
            machine.env.ui.info("Extracting #{src} to #{workdir}")
            machine.communicate.execute("cd #{workdir} && tar xvfz #{src}")
          end
        end
      end
    end
  end
end
