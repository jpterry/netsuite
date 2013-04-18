# -*- encoding: utf-8 -*-
require File.expand_path('../lib/netsuite/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ryan Moran', 'Michael Bianco']
  gem.email         = ['ryan.moran@gmail.com', 'info@cliffsidedev.com']
  gem.description   = %q{NetSuite SuiteTalk API Wrapper}
  gem.summary       = %q{NetSuite SuiteTalk API Wrapper}
  gem.homepage      = 'https://github.com/RevolutionPrep/netsuite'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'netsuite'
  gem.require_paths = ['lib']
  gem.version       = Netsuite::VERSION

  gem.add_dependency 'savon', '~> 2.1.0'
  gem.add_dependency 'nokogiri', '~> 1.5.0'

  gem.add_development_dependency 'rspec',                 '~> 2.10'
  gem.add_development_dependency 'autotest-standalone',   '~> 4.5'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'ci_reporter',           '~> 1.8'

end
