require Vagrant.source_root.join("plugins/provisioners/docker/client")
require Vagrant.source_root.join("plugins/provisioners/docker/installer")

require_relative "errors"
require_relative "services_builder"
require_relative "platforms_builder"

module VagrantPlugins
  module Ventriloquist
    # TODO: Improve handling of vagrant-lxc specifics (like checking for apparmor
    #       profile stuff + autocorrection)
    class Provisioner < Vagrant.plugin("2", :provisioner)
      def initialize(machine, config, installer = nil, client = nil)
        super(machine, config)
        @installer = installer || Docker::Installer.new(@machine, config.docker_version)
        @client    = client    || Docker::Client.new(@machine)
      end

      def provision
        @logger = Log4r::Logger.new("vagrant::provisioners::ventriloquist")

        provision_packages
        provision_services
        provision_platforms
      end

      protected

      def provision_packages
        return if config.packages.empty?

        if @machine.guest.capability?(:install_packages)
          @machine.guest.capability(:install_packages, config.packages)
        else
          @machine.env.ui.warn(I18n.t 'ventriloquist.install_packages_unsupported')
        end
      end

      def provision_services
        return if config.services.empty?

        @logger.info("Checking for Docker installation...")
        @installer.ensure_installed

        if @machine.guest.capability?(:ventriloquist_containers_upstart)
          @machine.guest.capability(:ventriloquist_containers_upstart)
        end

        if @machine.provider_name == :lxc && @machine.guest.capability?(:prepare_container_for_docker)
          @logger.info("vagrant-lxc container detected, will install lxc and tweak Docker settings")
          @machine.guest.capability(:prepare_container_for_docker)
        end

        unless @client.daemon_running?
          raise 'Docker client is not running'
        end

        ServicesBuilder.build(config.services, @client).each do |service|
          service.provision(@machine)
        end
      end

      def provision_platforms
        return if config.platforms.empty?

        # Install git so we can install "stuff" from sources
        @machine.guest.capability(:git_install)

        PlatformsBuilder.build(config.platforms).each do |platform|
          platform.provision(@machine)
        end
      end
    end
  end
end
