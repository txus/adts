# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adt/version'

Gem::Specification.new do |spec|
  spec.name          = "adts"
  spec.version       = ADT::VERSION
  spec.authors       = ["Josep M. Bach"]
  spec.email         = ["josep.m.bach@gmail.com"]
  spec.summary       = %q{Abstract Data Types for Ruby}
  spec.description   = %q{Abstract Data Types for Ruby}
  spec.homepage      = "http://blog.txus.io/adts"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
