module VagrantPlugins
  module Ventriloquist
    module Services
      class MailCatcher < Service
        def initialize(*args)
          super
          @config[:args] ||= '-p 1025:1025 -p 1080:1080'
        end
      end
    end
  end
end
