$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "restrictable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "restrictable"
  s.version     = Restrictable::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Restrictable."
  s.description = "TODO: Description of Restrictable."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "sqlite3"
end
