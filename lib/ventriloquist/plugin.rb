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

      guest_capability("debian", "nodejs_install") do
        require_relative "cap/debian/nodejs_install"
        Cap::Debian::NodejsInstall
      end

      guest_capability("linux", "rvm_install") do
        require_relative "cap/linux/rvm_install"
        Cap::Linux::RvmInstall
      end

      guest_capability("debian", "phantomjs_install") do
        require_relative "cap/debian/phantomjs_install"
        Cap::Debian::PhantomjsInstall
      end

      guest_capability("debian", "go_install") do
        require_relative "cap/debian/go_install"
        Cap::Debian::GoInstall
      end

      guest_capability("linux", "rvm_install_ruby") do
        require_relative "cap/linux/rvm_install_ruby"
        Cap::Linux::RvmInstallRuby
      end
    end
  end
end
