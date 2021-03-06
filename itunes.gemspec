# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "itunes/version"

Gem::Specification.new do |s|
  s.name = "itunes"
  s.version = ITunes::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Garrett Bjerkhoel", "Steve Agalloco"]
  s.email = %q{me@garrettbjerkhoel.com}
  s.homepage = %q{http://github.com/dewski/itunes}
  s.summary = %q{iTunes API}

  s.rubyforge_project = "itunes"

  s.extra_rdoc_files = [
    "MIT-LICENSE",
     "README.md"
  ]
  s.rdoc_options = ["--charset=UTF-8"]

  s.add_development_dependency('bundler', '~> 1.0')
  s.add_development_dependency('rake', '~> 0.8')
  s.add_development_dependency('rspec', '~> 2.5.0')
  s.add_development_dependency('yard', '~> 0.6')
  s.add_development_dependency('maruku', '~> 0.6')
  s.add_development_dependency('simplecov', '~> 0.3')
  s.add_development_dependency('webmock', '~> 1.6')
  s.add_development_dependency('vcr', '~> 1.4.0')
  s.add_development_dependency('json', '~> 1.5.1')

  s.add_runtime_dependency('hashie', '~> 1.0.0')
  s.add_runtime_dependency('rash', '~> 0.2.0')
  s.add_runtime_dependency('faraday', '~> 0.5.4')
  s.add_runtime_dependency('faraday_middleware', '~> 0.3.1')
  s.add_runtime_dependency('multi_json', '~> 0.0.5')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

