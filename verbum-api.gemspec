$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "verbum/api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name          = "verbum-api"
  spec.version       = Verbum::Api::VERSION
  spec.authors       = ["Jens Ljungblad"]
  spec.email         = ["jens.ljungblad@gmail.com"]
  spec.homepage      = "https://github.com/varvet/verbum-api-client"
  spec.summary       = "Ruby client for the Verbum API"
  spec.description   = "Ruby client for the Verbum API"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4.1"
  spec.add_dependency "faraday", "~> 0.9.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
