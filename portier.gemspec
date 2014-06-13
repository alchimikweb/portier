Gem::Specification.new do |gem|
  gem.name        = "portier"
  gem.description = "Portier is an gem that manage permissions in a rails project. The permission rules are flexible, non-obstrusive, scalable and can be applied to the controller actions, and views."
  gem.summary     = "Portier is an gem that manage permissions in a rails project. The permission rules are flexible, non-obstrusive, scalable and can be applied to the controller actions, and views."
  gem.homepage    = "https://bitbucket.org/alchimikweb/portier"
  gem.version     = "1.0.3"
  gem.licenses    = ["MIT"]

  gem.authors     = ["Sebastien Rosa"]
  gem.email       = ["sebastien@alchimik.com"]

  gem.files       = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", ['>= 4.0']
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "simplecov-rcov-text"
end
