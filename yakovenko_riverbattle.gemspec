# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yakovenko_riverbattle/version"

Gem::Specification.new do |s|
	s.name			= 'yakovenko_riverbattle'
	s.date			= '2015-07-04'
	s.summary		= 'Enjoy the game!'
	s.description	= 'A small simple game called the Riverbattle'
	s.platform		= Gem::Platform::RUBY
	s.version		= '0.1.0'
	s.authors		= ["Denis Yakovenko"]
	s.email			= ["yakovenko.denis.a@gmail.com"]
	s.require_paths = ["lib"]
	s.license		= "MIT"
end