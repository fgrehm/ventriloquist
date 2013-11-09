module VagrantPlugins
  module Ventriloquist
    class Plugin < Vagrant.plugin("2")
      guest_capability("debian", "git_install") do
        require_relative "cap/debian/git_install"
        Cap::Debian::GitInstall
      end

      guest_capability("debian", "mercurial_install") do
        require_relative "cap/debian/mercurial_install"
        Cap::Debian::MercurialInstall
      end

      guest_capability("linux", "make") do
        require_relative "cap/linux/make"
        Cap::Linux::Make
      end

      guest_capability("debian", "install_build_tools") do
        require_relative "cap/debian/install_build_tools"
        Cap::Debian::InstallBuildTools
      end

      guest_capability("linux", "download") do
        require_relative "cap/linux/download"
        Cap::Linux::Download
      end

      guest_capability("linux", "untar") do
        require_relative "cap/linux/untar"
        Cap::Linux::Untar
      end

      guest_capability("debian", "install_packages") do
        require_relative "cap/debian/install_packages"
        Cap::Debian::InstallPackages
      end
    end
  end
end
