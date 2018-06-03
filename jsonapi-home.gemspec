#!/usr/bin/env ruby

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jsonapi/home/version"

Gem::Specification.new do |spec|
  spec.name = "jsonapi-home"
  spec.version = JSONAPI::Home::VERSION
  spec.authors = ["Kurtis Rainbolt-Greene"]
  spec.email = ["kurtis@rainbolt-greene.online"]
  spec.summary = %q{An early implementation of JSONAPIHome, a fork of JSONHome}
  spec.description = spec.summary
  spec.homepage = "http://krainboltgreene.github.io/jsonapi-home"
  spec.license = "ISC"

  spec.files = Dir[File.join("{app,config,db,lib}", "**", "*"), "LICENSE", "README.md", "Rakefile"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "1.16.1"
  spec.add_development_dependency "rspec", "3.7.0"
  spec.add_development_dependency "rake", "12.3.1"
  spec.add_development_dependency "pry", "0.11.3"
  spec.add_development_dependency "pry-doc", "0.13.3"
  spec.add_development_dependency "sqlite3", "1.3.13"
  spec.add_runtime_dependency "rails", "~> 5.1"
  spec.add_runtime_dependency "jsonapi-realizer", "~> 4.1"
  spec.add_runtime_dependency "jsonapi-serializers", "~> 1.0"
  spec.add_runtime_dependency "array-where", "~> 2.0"
end
