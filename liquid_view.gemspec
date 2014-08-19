# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'liquid_view/version'

Gem::Specification.new do |spec|
  spec.name          = 'liquid_view'
  spec.version       = LiquidView::VERSION
  spec.authors       = ['Chamnap Chhorn']
  spec.email         = ['chamnapchhorn@gmail.com']
  spec.summary       = %q{Renders liquid templates with layout and partial support}
  spec.description   = %q{Renders liquid templates with layout and partial support}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 3.2'
  spec.add_dependency 'liquid', '~> 3.0.0.rc1'
  spec.add_dependency 'thor'
end