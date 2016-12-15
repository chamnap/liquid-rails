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
  spec.required_ruby_version     = '>= 2.0.0'
  spec.required_rubygems_version = '>= 1.8.11'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails',    '>= 3.2'
  spec.add_dependency 'liquid',   '~> 3.0'
  spec.add_dependency 'kaminari', '>= 0.16.1'
end
