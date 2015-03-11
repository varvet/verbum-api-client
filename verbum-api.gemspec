$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "verbum/api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name          = "verbum-api"
  gem.version       = Verbum::Api::VERSION
  gem.authors       = ["Jens Ljungblad"]
  gem.email         = ["jens.ljungblad@gmail.com"]
  gem.homepage      = "https://github.com/varvet/verbum-api-client"
  gem.summary       = "Ruby client for the Verbum API"
  gem.description   = "Ruby client for the Verbum API"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activesupport", "~> 4.1"
  gem.add_dependency "faraday", "~> 0.9.0"

  gem.add_development_dependency "bundler", "~> 1.7"
  gem.add_development_dependency "rake", "~> 10.0"
end
