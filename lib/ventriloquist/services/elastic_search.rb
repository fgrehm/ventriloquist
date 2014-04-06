module VagrantPlugins
  module Ventriloquist
    module Services
      class ElasticSearch < Service
        def initialize(*args)
          super
          @config[:args] ||= '-p 9292:9292'
        end
      end
    end
  end
end
