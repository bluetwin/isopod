Gem::Specification.new do |s|
  s.name               = "isopod"
  s.version            = "0.0.0"
  s.default_executable = "isopod"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brandon Sislow"]
  s.date = %q{2013-04-25}
  s.description = %q{A pdf deconstruction and recontruction gem. More coming soon, I promise}
  s.email = %q{brandon@bluetwin.com}
  s.files = ["Rakefile", "lib/isopod.rb", "lib/isopod/translator.rb", "lib/isopod/trailer.rb", "bin/isopod"]
  s.test_files = ["test/test_isopod.rb"]
  s.homepage = %q{http://rubygems.org/gems/isopod}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{2.0.3}
  s.summary = %q{Isopod!}

  if s.respond_to? :specification_version then
    s.specification_version = 3
    s.add_runtime_dependency "file-tail",["= 1.0.12"]
    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

