require 'mongoid'
require 'action_view'

module LocalizedFields
  extend ActiveSupport::Autoload

  autoload :FormBuilder
  autoload :Helpers
end

ActionView::Helpers::FormBuilder.send :include, LocalizedFields::Helpers::FormHelper
