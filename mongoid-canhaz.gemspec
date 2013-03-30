# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid-canhaz/version'

Gem::Specification.new do |gem|
  gem.name          = "mongoid-canhaz"
  gem.version       = Canhaz::Mongoid::VERSION
  gem.authors       = ["Intrepidd"]
  gem.email         = ["adrien@siami.fr"]
  gem.description   = "A simple mongoid extention that allows any application using mongoid to manage permissions based roles."
  gem.summary       = "A simple mongoid extention that allows any application using mongoid to manage permissions based roles."
  gem.homepage      = "https://github.com/Intrepidd/mongoid-canhaz/"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'mongoid', '>= 2.2.0'
end
