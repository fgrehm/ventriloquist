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

      require_relative("plugin/debian.rb")
      require_relative("plugin/linux.rb")
    end
  end
end
