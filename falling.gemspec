# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'falling/version'

Gem::Specification.new do |spec|
  spec.name          = "falling"
  spec.version       = Falling::VERSION
  spec.authors       = ["Jared Norman"]
  spec.email         = ["jared@creepywizard.com"]

  spec.summary       = 'A simple roguelike game.'
  spec.description   = 'A simple roguelike game.'
  spec.homepage      = "http://www.creepywizard.com"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19.1"
  spec.add_dependency "curses", "~> 1.0"

  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop", "~> 0.36"
  spec.add_development_dependency "yard", "~> 0.8.7"
end
