module VagrantPlugins
  module Ventriloquist
    class Plugin
      guest_capability("debian", "pg_install_client") do
        require_relative "../cap/debian/pg_install_client"
        Cap::Debian::PgInstallClient
      end

      guest_capability("debian", "pg_install_headers") do
        require_relative "../cap/debian/pg_install_headers"
        Cap::Debian::PgInstallHeaders
      end

      guest_capability("debian", "mysql_install_client") do
        require_relative "../cap/debian/mysql_install_client"
        Cap::Debian::MySqlInstallClient
      end

      guest_capability("debian", "mysql_install_headers") do
        require_relative "../cap/debian/mysql_install_headers"
        Cap::Debian::MySqlInstallHeaders
      end

      guest_capability("debian", "git_install") do
        require_relative "../cap/debian/git_install"
        Cap::Debian::GitInstall
      end

      guest_capability("debian", "mercurial_install") do
        require_relative "../cap/debian/mercurial_install"
        Cap::Debian::MercurialInstall
      end

      guest_capability("debian", "install_build_tools") do
        require_relative "../cap/debian/install_build_tools"
        Cap::Debian::InstallBuildTools
      end

      guest_capability("debian", "ventriloquist_containers_upstart") do
        require_relative "../cap/debian/ventriloquist_containers_upstart"
        Cap::Debian::VentriloquistContainersUpstart
      end

      guest_capability("debian", "phantomjs_install") do
        require_relative "../cap/debian/phantomjs_install"
        Cap::Debian::PhantomjsInstall
      end

      guest_capability("debian", "go_install") do
        require_relative "../cap/debian/go_install"
        Cap::Debian::GoInstall
      end

      guest_capability("debian", "erlang_install") do
        require_relative "../cap/debian/erlang_install"
        Cap::Debian::ErlangInstall
      end
    end
  end
end
