# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ventriloquist/version'

Gem::Specification.new do |spec|
  spec.name          = "ventriloquist"
  spec.version       = VagrantPlugins::Ventriloquist::VERSION
  spec.authors       = ["Fabio Rehm"]
  spec.email         = ["fgrehm@gmail.com"]
  spec.description   = %q{Vagrant development environments made easy}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/fgrehm/ventriloquist"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'vocker', '~> 0.3.1'
end
