# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'usermanagecli/version'

Gem::Specification.new do |spec|
  spec.name          = "usermanagecli"
  spec.version       = Usermanagecli::VERSION
  spec.authors       = ["Chris Meadows"]
  spec.email         = ["meadoch1@gmail.com"]
  spec.description   = %q{Command line interface to the usermanage API}
  spec.summary       = %q{Used for managing user passwords and roles}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "json", "~>  1.7.7"
  spec.add_dependency "gli"
  spec.add_dependency "rest-client"
  spec.add_dependency "terminal-table"
end
