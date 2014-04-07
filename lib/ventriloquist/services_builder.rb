require_relative 'service'
require_relative 'services/postgresql'
require_relative 'services/redis'
require_relative 'services/mail_catcher'
require_relative 'services/memcached'
require_relative 'services/mysql'
require_relative 'services/elastic_search'
require_relative 'services/rethink_db'

module VagrantPlugins
  module Ventriloquist
    class ServicesBuilder
      MAPPING = {
        'postgres'      => Services::PostgreSQL,
        'elasticsearch' => Services::ElasticSearch,
        'mailcatcher'   => Services::MailCatcher,
        'mysql'         => Services::MySql,
        'redis'         => Services::Redis,
        'memcached'     => Services::Memcached,
        'rethinkdb'     => Services::RethinkDB,
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
        type = extract_service_type(config.delete(:type) || name)

        config[:image] ||= extract_image_name(config.delete(:vimage) || name)

        klass = @mapping.fetch(type, Service)
        klass.new(name.to_s, config, docker_client)
      end

      def extract_image_name(name)
        if name =~ /(\w+\/\w+)/
          $1
        # HACK: This should be noted on the README
        elsif name =~ /^elasticsearch-(\d+\.\d+)$/
          "fgrehm/ventriloquist-es-#{$1}"
        else
          "fgrehm/ventriloquist-#{name}"
        end
      end

      def extract_service_type(type)
        type.to_s.split('-').first
      end
    end
  end
end
