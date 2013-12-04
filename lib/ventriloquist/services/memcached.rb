module VagrantPlugins
  module Ventriloquist
    module Services
      class Memcached < Service
        def initialize(*args)
          super
          @config[:ports] ||= ['11211:11211']
        end
      end
    end
  end
end
