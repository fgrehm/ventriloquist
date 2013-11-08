require_relative 'service'
require_relative 'services/postgresql'
require_relative 'services/redis'
require_relative 'services/mail_catcher'
require_relative 'services/memcached'
require_relative 'services/mysql'
require_relative 'services/elastic_search'

module VagrantPlugins
  module Ventriloquist
    class ServicesBuilder
      MAPPING = {
        'pg'            => Services::PostgreSQL,
        'elasticsearch' => Services::ElasticSearch,
        'mailcatcher'   => Services::MailCatcher,
        'mysql'         => Services::MySql,
        'redis'         => Services::Redis,
        'memcached'     => Services::Memcached,
      }

      def initialize(services, mapping = MAPPING)
        @services = services.flatten
        @mapping  = mapping
      end

      def self.build(services, docker_client)
        new(services).build(docker_client)
      end

      def build(docker_client)
        @services.each_with_object([]) do |cfg, built_services|
          case cfg
            when Hash
              built_services.concat build_services(cfg, docker_client)
            when String, Symbol
              built_services << create_service_provisioner(cfg, {}, docker_client)
            else
              raise "Unknown cfg type: #{cfg.class}"
          end
        end
      end

      private

      def build_services(cfg_hash, docker_client)
        cfg_hash.map do |name, config|
          create_service_provisioner(name, config, docker_client)
        end
      end

      def create_service_provisioner(name, config, docker_client)
        name, tag = name.to_s.split(':')

        # REFACTOR: This is a bit confusing...
        config[:tag]   ||= (tag || 'latest')
        config[:image] ||= extract_image_name(name)
        config[:image] << ":#{config[:tag]}"

        klass = @mapping.fetch(name, Service)
        klass.new(name, config, docker_client)
      end

      def extract_image_name(name)
        if name =~ /(\w+\/\w+)/
          $1
        else
          "fgrehm/ventriloquist-#{name}"
        end
      end
    end
  end
end
