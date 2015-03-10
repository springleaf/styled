$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "styled/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "styled"
  s.version     = Styled::VERSION

  s.authors     = ["Erik Peterson"]
  s.email       = ["thecompanygardener@gmail.com"]
  s.license     = "MIT"

  s.homepage    = "http://www.github.com/companygardener/styled"
  s.summary     = "An engine with style."
  s.description = "Generate styleguides for your CSS, easily."

  s.files       = `git ls-files -z`.split("\x0")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "google-code-prettify-rails"
  s.add_dependency "less-rails"
end
