# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'learndot/version'

Gem::Specification.new do |gem|
  gem.name          = "learndot"
  gem.version       = Learndot::VERSION
  gem.authors       = ["Joe Gaudet"]
  gem.email         = ["joe@learndot.com"]
  gem.description   = 'A wrapper for the Learndot API'
  gem.summary       = ''
  gem.homepage      = 'https://github.com/learndot/learndot.rb'

  gem.files         = `git ls-files`.split($/)
  gem.executables  = ['dump_assessment', 'update_assessment']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_runtime_dependency 'json', ' ~> 1.8.0'
  gem.add_runtime_dependency 'rails'
  gem.add_runtime_dependency 'trollop'
  gem.add_runtime_dependency 'httparty'
  gem.add_runtime_dependency 'persistent_httparty'

end
