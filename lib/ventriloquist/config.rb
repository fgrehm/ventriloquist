module VagrantPlugins
  module Ventriloquist
    class Config < Vagrant.plugin("2", :config)
      attr_reader :services, :platforms

      def initialize
        @services  = []
        @platforms = []
      end
    end
  end
end
