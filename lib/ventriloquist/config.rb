module VagrantPlugins
  module Ventriloquist
    class Config < Vagrant.plugin("2", :config)
      attr_reader :services, :platforms, :packages
      attr_accessor :docker_version

      def initialize
        @services       = []
        @platforms      = []
        @packages       = []
        @docker_version = '0.7.0'
      end
    end
  end
end
