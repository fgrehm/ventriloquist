module VagrantPlugins
  module Ventriloquist
    class Plugin
      guest_capability("linux", "pg_export_pghost") do
        require_relative "../cap/linux/pg_export_pghost"
        Cap::Linux::PgExportPghost
      end

      guest_capability("linux", "mysql_configure_client") do
        require_relative "../cap/linux/mysql_configure_client"
        Cap::Linux::MySqlConfigureClient
      end

      guest_capability("linux", "make") do
        require_relative "../cap/linux/make"
        Cap::Linux::Make
      end

      guest_capability("linux", "download") do
        require_relative "../cap/linux/download"
        Cap::Linux::Download
      end

      guest_capability("linux", "untar") do
        require_relative "../cap/linux/untar"
        Cap::Linux::Untar
      end

      guest_capability("linux", "rvm_install") do
        require_relative "../cap/linux/rvm_install"
        Cap::Linux::RvmInstall
      end

      guest_capability("linux", "rvm_install_ruby") do
        require_relative "../cap/linux/rvm_install_ruby"
        Cap::Linux::RvmInstallRuby
      end

      guest_capability("linux", "nvm_install") do
        require_relative "../cap/linux/nvm_install"
        Cap::Linux::NvmInstall
      end

      guest_capability("linux", "nvm_install_nodejs") do
        require_relative "../cap/linux/nvm_install_nodejs"
        Cap::Linux::NvmInstallNodeJS
      end
    end
  end
end
