# -*- encoding: utf-8 -*-
require File.expand_path('../lib/localized_fields/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Tiago Rafael Godinho']
  gem.email         = ['tiagogodinho3@gmail.com']
  gem.description   = %q{Helps you to create forms with localized fields using Mongoid.}
  gem.summary       = %q{Localized Fields provides form helpers to create forms with localized fields using Mongoid.}
  gem.homepage      = 'https://github.com/tiagogodinho/localized_fields'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'localized_fields'
  gem.require_paths = ['lib']
  gem.version       = LocalizedFields::VERSION

  gem.add_dependency 'mongoid',    '>= 2.4'
  gem.add_dependency 'actionpack', '>= 3.0.0'

  gem.add_development_dependency 'rake', '~> 10.1.0'
  gem.add_development_dependency 'rspec', '~> 2.14.0'
  gem.add_development_dependency 'coveralls'
end
