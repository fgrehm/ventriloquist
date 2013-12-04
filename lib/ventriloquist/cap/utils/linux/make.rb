module VagrantPlugins
  module Ventriloquist
    module Cap
      module Linux
        module Make
          def self.make(machine, workdir, target = 'all')
            machine.env.ui.info("Running `make #{target}` on #{workdir}")
            machine.communicate.execute("cd #{workdir} && make #{target}")
          end
        end
      end
    end
  end
end
