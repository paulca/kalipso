# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kalipso}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Campbell"]
  s.date = %q{2011-01-26}
  s.default_executable = %q{kalipso}
  s.description = %q{A full library for interactiing with your sites using kalipso}
  s.email = %q{paul@rslw.com}
  s.executables = ["kalipso"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/kalipso",
    "kalipso.gemspec",
    "lib/kalipso.rb",
    "lib/kalipso/cli.rb",
    "lib/kalipso/site.rb"
  ]
  s.homepage = %q{http://github.com/paulca/kalipso}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{Client library and command line client for kalipso}
  s.test_files = [
    "spec/kalipso_spec.rb",
    "spec/lib/kalipso/cli_spec.rb",
    "spec/site_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/kalipso.rb",
    "spec/support/vcr.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jaysus>, [">= 0"])
      s.add_runtime_dependency(%q<thor>, [">= 0"])
      s.add_runtime_dependency(%q<highline>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<vcr>, ["= 1.5.1"])
      s.add_development_dependency(%q<webmock>, ["= 1.6.2"])
    else
      s.add_dependency(%q<jaysus>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<highline>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<vcr>, ["= 1.5.1"])
      s.add_dependency(%q<webmock>, ["= 1.6.2"])
    end
  else
    s.add_dependency(%q<jaysus>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<highline>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<vcr>, ["= 1.5.1"])
    s.add_dependency(%q<webmock>, ["= 1.6.2"])
  end
end

