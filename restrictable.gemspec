$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devise/restrictable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "restrictable"
  s.version     = Restrictable::VERSION
  s.authors     = ["wmalheiros"]
  s.email       = ["wenderson.malheiros@gmail.com"]
  s.homepage    = "https://github.com/wmalheiros/restrictable"
  s.summary     = %q{Activate and inactivate a devise account}
  s.description = %q{This is a simple, however wonderful devise extension to activate and inactivate users account.}
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]


  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
  s.add_dependency "devise", ">= 2.0"

  s.add_development_dependency "sqlite3"
end
