require 'coveralls'
Coveralls.wear!

require 'localized_fields'

Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each { |f| require f }

def rails3?
  !defined?(ActionView::VERSION::MAJOR)
end

def rails4?
  ActionView::VERSION::MAJOR == 4
end
