module VagrantPlugins
  module Ventriloquist
    module Services
      class MailCatcher < Service
        def initialize(*args)
          super
          @config[:ports] ||= ['1025:1025', '1080:1080']
        end
      end
    end
  end
end
