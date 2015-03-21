require 'mongoid'
require 'action_view'

module LocalizedFields
  extend ActiveSupport::Autoload

  autoload :FormBuilder
  autoload :Helpers


  class << self

    def configuration
      @configuration ||= Configuration.new
    end

    def configuration=(config)
      @configuration = config
    end

    def configure
      yield(configuration)
    end

  end

  class Configuration
    attr_accessor :used_locales

    def initialize
      self.used_locales = I18n.available_locales
    end
  end



end

ActionView::Helpers::FormBuilder.send :include, LocalizedFields::Helpers::FormHelper
