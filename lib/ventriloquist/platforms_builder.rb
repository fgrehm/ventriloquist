require_relative 'platform'
require_relative 'platforms/ruby'
require_relative 'platforms/nodejs'
require_relative 'platforms/phantomjs'
require_relative 'platforms/go'
require_relative 'platforms/erlang'
require_relative 'platforms/elixir'
require_relative 'platforms/python'

module VagrantPlugins
  module Ventriloquist
    class PlatformsBuilder
      MAPPING = {
        'ruby'      => Platforms::Ruby,
        'nodejs'    => Platforms::NodeJS,
        'phantomjs' => Platforms::PhantomJS,
        'go'        => Platforms::Go,
        'erlang'    => Platforms::Erlang,
        'elixir'    => Platforms::Elixir,
        'python'    => Platforms::Python
      }

      def initialize(platforms, mapping = MAPPING)
        @platforms = platforms.flatten
        @mapping   = mapping
      end

      def self.build(platforms)
        new(platforms).build
      end

      def build
        @platforms.each_with_object([]) do |cfg, built_platforms|
          case cfg
            when Hash
              built_platforms.concat build_platforms(cfg)
            when String, Symbol
              built_platforms << create_platform_provisioner(cfg, {})
            else
              raise "Unknown cfg type: #{cfg.class}"
          end
        end
      end

      private

      def build_platforms(cfg_hash)
        cfg_hash.map do |name, config|
          create_platform_provisioner(name, config)
        end
      end

      def create_platform_provisioner(name, config)
        name, version = name.to_s.split(':')
        config[:version] ||= (version || 'latest')

        klass = @mapping.fetch(name.to_s)
        klass.new(name, config)
      end
    end
  end
end
