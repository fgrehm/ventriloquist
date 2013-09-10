module VagrantPlugins
  module Ventriloquist
    class Platform
      attr_reader :name, :config

      def initialize(name, config)
        @name, @config = name, config
      end
    end
  end
end
