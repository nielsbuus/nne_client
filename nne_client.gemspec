# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)
require 'nne_client/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Jacob Atzen"]
  gem.email         = ["jacob@incremental.dk"]
  gem.description   = %q{Client library for the Navne & Numre Erhverv SOAP service}
  gem.summary       = %q{A small library easing integration with NNE}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nne_client"
  gem.require_paths = ["lib"]
  gem.version       = NNEClient::VERSION
  gem.add_dependency('savon', '~> 0.9.5')
  gem.add_dependency('config_newton', '~> 0.1.1')
  gem.add_development_dependency('vcr')
  gem.add_development_dependency('fakeweb')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency("equivalent-xml", "~> 0.2.9")
end
