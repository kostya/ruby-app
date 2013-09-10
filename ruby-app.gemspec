# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/ruby-app/version"

Gem::Specification.new do |s|
  s.name = %q{ruby-app}
  s.version = RubyApp::VERSION

  s.authors = ["Makarchev Konstantin"]

  s.description = %q{Ruby micro framework for easy create ruby applications (daemons, EventMachine-apps, db-apps, cli...). Features: bundler, environments, activesupport, rails dirs tree. Fast loading and low memory using.}
  s.summary = %q{Ruby application micro framework}

  s.email = %q{kostya27@gmail.com}
  s.homepage = %q{http://github.com/kostya/ruby-app}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport'
  s.add_dependency 'rake'
  s.add_dependency 'thor'
  s.add_dependency "bundler"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

end
