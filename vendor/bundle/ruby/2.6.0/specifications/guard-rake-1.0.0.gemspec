# -*- encoding: utf-8 -*-
# stub: guard-rake 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "guard-rake".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Scott Barron".freeze]
  s.date = "2014-11-06"
  s.description = "guard-rake automatically runs Rake tasks from your Rakefile".freeze
  s.email = ["scott@elitists.net".freeze]
  s.homepage = "http://github.com/rubyist/guard-rake".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Guard for running rake tasks".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<guard>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<guard>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
