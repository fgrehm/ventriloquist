module VagrantPlugins
  module Ventriloquist
    module Services
      class RethinkDB < Service
        def initialize(*args)
          super
          @config[:args] ||= '-p 28015:28015 -p 29015:29015 -p 8080:8080'
        end
      end
    end
  end
end
