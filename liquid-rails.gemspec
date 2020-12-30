# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liquid-rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'liquid-rails'
  spec.version       = Liquid::Rails::VERSION
  spec.authors       = ['Chamnap Chhorn']
  spec.email         = ['chamnapchhorn@gmail.com']
  spec.summary       = %q{Renders liquid templates with layout and partial support}
  spec.description   = %q{It allows you to render .liquid templates with layout and partial support. It also provides filters, tags, drops class to be used inside your liquid template.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.required_ruby_version     = '>= 2.0'
  spec.required_rubygems_version = '>= 1.8'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails',    ">= 6.0"
  spec.add_dependency 'liquid',   '~> 4.0'
  spec.add_dependency 'kaminari', '~> 1.2'

  spec.add_development_dependency 'rspec-rails', '~> 4.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'capybara',    '~> 3.34'
  spec.add_development_dependency 'pry-rails',   '~> 0.3'
  spec.add_development_dependency 'coveralls',   '~> 0.8'
  spec.add_development_dependency 'simplecov',   '~> 0.16'
  spec.add_development_dependency 'sqlite3',     '~> 1.4'
end
