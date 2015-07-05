# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yakovenko_riverbattle/version'

Gem::Specification.new do |spec|
  spec.name          = "yakovenko_riverbattle"
  spec.version       = YakovenkoRiverbattle::VERSION
  spec.authors       = ["Denis Yakovenko"]
  spec.email         = ["yakovenko.denis.a@gmail.com"]

  spec.summary       = %q{Enjoy the game!}
  spec.description   = %q{A small simple game called the Riverbattle.}
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   = ["riverbattle"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
