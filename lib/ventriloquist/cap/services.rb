module VagrantPlugins
  module Ventriloquist
    class Plugin < Vagrant.plugin("2")
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
    end
  end
end
