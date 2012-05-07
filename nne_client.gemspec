# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nne_client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jacob Atzen"]
  gem.email         = ["jacob@incremental.dk"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nne_client"
  gem.require_paths = ["lib"]
  gem.version       = NNEClient::VERSION
  gem.add_dependency('savon', '~> 0.9.9')
  gem.add_development_dependency('vcr')
  gem.add_development_dependency('fakeweb')
  gem.add_development_dependency('rspec')
end
