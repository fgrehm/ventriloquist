module VagrantPlugins
  module Ventriloquist
    module Services
      class RethinkDB < Service
        def initialize(*args)
          super
          @config[:ports] ||= [
            '28015:28015',
            '29015:29015',
            '8080:8080'
          ]
        end
      end
    end
  end
end
