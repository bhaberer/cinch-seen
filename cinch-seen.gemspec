# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch/plugins/seen/version'

Gem::Specification.new do |gem|
  gem.name          = 'cinch-seen'
  gem.version       = Cinch::Plugins::Seen::VERSION
  gem.authors       = ['Brian Haberer']
  gem.email         = ['bhaberer@gmail.com']
  gem.description   = %q(Cinch Plugin to allow users to find out how long it's been since a user was active)
  gem.summary       = %q(Cinch Plugin for Seen)
  gem.homepage      = 'https://github.com/bhaberer/cinch-seen'
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^(test|spec|features)\//)
  gem.require_paths = ['lib']
  gem.add_development_dependency 'rake', '~> 10'
  gem.add_development_dependency 'rspec', '~> 3'
  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_development_dependency 'cinch-test', '~> 0.1', '>= 0.1.0'
  gem.add_dependency 'cinch', '~> 2'
  gem.add_dependency 'cinch-cooldown', '~> 1.1', '>= 1.1.1'
  gem.add_dependency 'cinch-storage', '~> 1.1'
  gem.add_dependency 'cinch-toolbox', '~> 1.1'
end
