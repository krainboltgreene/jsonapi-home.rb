#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "lib/jsonapi/home/version"

Gem::Specification.new do |spec|
  spec.name = "jsonapi-home"
  spec.version = JSONAPI::Home::VERSION
  spec.authors = ["Kurtis Rainbolt-Greene"]
  spec.email = ["kurtis@rainbolt-greene.online"]
  spec.summary = "An implementation of JSONAPIHome, a fork of JSONHome using json:api"
  spec.description = spec.summary
  spec.homepage = "https://github.com/krainboltgreene/jsonapi-home.rb"
  spec.license = "HL3"
  spec.required_ruby_version = "~> 3.2"

  spec.files = Dir[File.join("lib", "**", "*"), "LICENSE", "README.md", "Rakefile"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "array-where", "~> 2.0"
  spec.add_runtime_dependency "jsonapi-materializer", "~> 1.0"
  spec.add_runtime_dependency "jsonapi-realizer", "~> 6.0"
  spec.add_runtime_dependency "rails"
  spec.metadata["rubygems_mfa_required"] = "true"
end
