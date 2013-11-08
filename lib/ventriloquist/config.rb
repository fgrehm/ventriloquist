module VagrantPlugins
  module Ventriloquist
    class Config < Vagrant.plugin("2", :config)
      attr_reader :services, :platforms
      attr_accessor :docker_version

      def initialize
        @services       = []
        @platforms      = []
        @docker_version = :latest
      end
    end
  end
end
