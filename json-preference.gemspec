# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json-preference/version'

Gem::Specification.new do |gem|
  gem.name          = "json-preference"
  gem.version       = JsonPreference::VERSION
  gem.authors       = ["Tai Do"]
  gem.email         = ["tai.do@partech.com"]
  gem.description   = %q{Json Preferences for your models}
  gem.summary       = %q{Json Preferences for your models}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "activesupport", ">= 3.0.0"
  gem.add_runtime_dependency "activerecord", ">= 3.0.0"

  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'rspec', ">= 3.0.0"
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency "shoulda"
  gem.add_development_dependency "appraisal"
end
