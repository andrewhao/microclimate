# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'microclimate/version'

Gem::Specification.new do |spec|
  spec.name          = "microclimate"
  spec.version       = Microclimate::VERSION
  spec.authors       = ["Andrew Hao"]
  spec.email         = ["ahao@blurb.com"]
  spec.description   = "An API wrapper for the Code Climate API"
  spec.summary       = "An API wrapper for the Code Climate API"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "psych"
  spec.add_runtime_dependency "hashie"
  spec.add_runtime_dependency "faraday"
end
