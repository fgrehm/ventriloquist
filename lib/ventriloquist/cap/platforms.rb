module VagrantPlugins
  module Ventriloquist
    class Plugin < Vagrant.plugin("2")
      guest_capability("linux", "nvm_install") do
        require_relative "platforms/linux/nvm_install"
        Cap::Linux::NvmInstall
      end

      guest_capability("linux", "nvm_install_nodejs") do
        require_relative "platforms/linux/nvm_install_nodejs"
        Cap::Linux::NvmInstallNodeJS
      end

      guest_capability("linux", "rvm_install") do
        require_relative "platforms/linux/rvm_install"
        Cap::Linux::RvmInstall
      end

      guest_capability("linux", "rvm_install_ruby") do
        require_relative "platforms/linux/rvm_install_ruby"
        Cap::Linux::RvmInstallRuby
      end

      guest_capability("debian", "phantomjs_install") do
        require_relative "platforms/debian/phantomjs_install"
        Cap::Debian::PhantomjsInstall
      end

      guest_capability("debian", "go_install") do
        require_relative "platforms/debian/go_install"
        Cap::Debian::GoInstall
      end

      guest_capability("debian", "erlang_install") do
        require_relative "platforms/debian/erlang_install"
        Cap::Debian::ErlangInstall
      end

      guest_capability("debian", "elixir_install") do
        require_relative "platforms/debian/elixir_install"
        Cap::Debian::ElixirInstall
      end

      guest_capability("debian", "pyenv_install") do
        require_relative "platforms/debian/python"
        Cap::Debian::Python
      end

      guest_capability("debian", "pyenv_install_python") do
        require_relative "platforms/debian/python"
        Cap::Debian::Python
      end
    end
  end
end
