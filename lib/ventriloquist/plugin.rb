require "vagrant"

Vagrant.require_plugin "vocker"

require_relative "version"

I18n.load_path << File.expand_path(File.dirname(__FILE__) + '/../../locales/en.yml')
I18n.reload!

module VagrantPlugins
  module Ventriloquist
    class Plugin < Vagrant.plugin("2")
      name "Ventriloquist"
      description <<-DESC
      Vagrant development environments made easy
      DESC

      provisioner(:ventriloquist) do
        require_relative "provisioner"
        Provisioner
      end

      config(:ventriloquist, :provisioner) do
        require_relative "config"
        Config
      end

      # Utils

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

      # Services related

      guest_capability("debian", "ventriloquist_containers_upstart") do
        require_relative "cap/debian/ventriloquist_containers_upstart"
        Cap::Debian::VentriloquistContainersUpstart
      end

      guest_capability("debian", "pg_install_client") do
        require_relative "cap/debian/pg_install_client"
        Cap::Debian::PgInstallClient
      end

      guest_capability("debian", "pg_install_headers") do
        require_relative "cap/debian/pg_install_headers"
        Cap::Debian::PgInstallHeaders
      end

      guest_capability("linux", "pg_export_pghost") do
        require_relative "cap/linux/pg_export_pghost"
        Cap::Linux::PgExportPghost
      end

      guest_capability("debian", "mysql_install_client") do
        require_relative "cap/debian/mysql_install_client"
        Cap::Debian::MySqlInstallClient
      end

      guest_capability("debian", "mysql_install_headers") do
        require_relative "cap/debian/mysql_install_headers"
        Cap::Debian::MySqlInstallHeaders
      end

      guest_capability("linux", "mysql_configure_client") do
        require_relative "cap/linux/mysql_configure_client"
        Cap::Linux::MySqlConfigureClient
      end

      # Platforms related

      guest_capability("linux", "nvm_install") do
        require_relative "cap/linux/nvm_install"
        Cap::Linux::NvmInstall
      end

      guest_capability("linux", "nvm_install_nodejs") do
        require_relative "cap/linux/nvm_install_nodejs"
        Cap::Linux::NvmInstallNodeJS
      end

      guest_capability("linux", "rvm_install") do
        require_relative "cap/linux/rvm_install"
        Cap::Linux::RvmInstall
      end

      guest_capability("linux", "rvm_install_ruby") do
        require_relative "cap/linux/rvm_install_ruby"
        Cap::Linux::RvmInstallRuby
      end

      guest_capability("debian", "phantomjs_install") do
        require_relative "cap/debian/phantomjs_install"
        Cap::Debian::PhantomjsInstall
      end

      guest_capability("debian", "go_install") do
        require_relative "cap/debian/go_install"
        Cap::Debian::GoInstall
      end

      guest_capability("debian", "erlang_install") do
        require_relative "cap/debian/erlang_install"
        Cap::Debian::ErlangInstall
      end

      guest_capability("debian", "elixir_install") do
        require_relative "cap/debian/elixir_install"
        Cap::Debian::ElixirInstall
      end

      guest_capability("debian", "pyenv_install") do
        require_relative "cap/debian/python"
        Cap::Debian::Python
      end

      guest_capability("debian", "pyenv_install_python") do
        require_relative "cap/debian/python"
        Cap::Debian::Python
      end
    end
  end
end
