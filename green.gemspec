# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'green/version'

Gem::Specification.new do |s|
  s.name = "green"
  s.version = Green::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Ben Caldwell", "Mark Ratjens"]
  s.email = ["support@habanerohq.com"]
  s.homepage = "http://www.habanerohq.com"
  s.summary = %q{}

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # todo: rails dependencies

  s.add_dependency 'less-rails-bootstrap', '2.0.8'
  s.add_dependency 'awesome_nested_set', '2.1.2'
  s.add_dependency 'acts_as_list', '0.1.5'
  s.add_dependency 'friendly_id', '4.0.3'
  s.add_dependency 'cells', '3.8.3'
  s.add_dependency 'kaminari', '0.13.0'
  s.add_dependency 'simple_form', '2.0.1'
  s.add_dependency 'commonjs', '0.2.0' # todo: confirm this is required
  s.add_dependency 'acts-as-taggable-on', '2.2.2'
  s.add_dependency 'rdiscount', '1.6.8'
  s.add_dependency 'devise', '~> 2.1'
  s.add_dependency 'cancan'
end
