# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kazoo/version"

Gem::Specification.new do |s|
  s.name        = "kazoo"
  s.version     = Kazoo::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zhao Lu"]
  s.email       = %q{zlu@me.com}
  s.date        = %q{2012-07-30}
  s.homepage    = "https://github.com/zlu/kazoo-rb"
  s.summary     = %q{Ruby wrapper for Kazoo}
  s.description = %q{Ruby wrapper for Kazoo, a powerful telephony platform}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.rdoc_options = %w{--charset=UTF-8}
  s.extra_rdoc_files = %w{README.md}

  s.add_dependency("nestful")

  s.add_development_dependency("rspec")
  s.add_development_dependency("webmock")
end