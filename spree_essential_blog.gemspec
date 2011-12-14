# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spree_essential_blog/version"

Gem::Specification.new do |s|
  s.name        = "spree_essential_blog"
  s.version     = SpreeEssentialBlog::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spencer Steffen"]
  s.email       = ["spencer@citrusme.com"]
  s.homepage    = "https://github.com/citrus/spree_essential_blog"
  s.summary     = %q{Spree Essential Blog is a blog plugin for Spree sites equipped with spree_essentials.}
  s.description = %q{Spree Essential Blog is a blog plugin for Spree sites equipped with spree_essentials.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  
  s.require_paths = ["lib"]

  # Runtime  
  s.add_dependency('spree_essentials',    '>= 0.3.0')
  s.add_dependency('acts-as-taggable-on', '>= 2.2.0')

  # Development
	s.add_development_dependency('shoulda',            '>= 3.0.0.beta2')
	s.add_development_dependency('dummier',            '>= 0.2.4')
	s.add_development_dependency('factory_girl',       '>= 2.3.2')
	s.add_development_dependency('capybara',           '>= 1.1.2')
	s.add_development_dependency('selenium-webdriver', '>= 2.15.0')
  s.add_development_dependency('sqlite3',            '>= 1.3.5')
  s.add_development_dependency('spork',              '>= 0.9.0.rc9')
  s.add_development_dependency('spork-testunit',     '>= 0.0.7')
  
end
