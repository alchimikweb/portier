Gem::Specification.new do |gem|
  gem.name        = "portier"
  gem.description = "Portier is an gem that manage permissions in a rails project. The permission rules are flexible, non-obstrusive, scalable and can be applied to the controller actions, and views."
  gem.summary     = "Portier is an gem that manage permissions in a rails project. The permission rules are flexible, non-obstrusive, scalable and can be applied to the controller actions, and views."
  gem.homepage    = "https://github.com/alchimikweb/portier"
  gem.version     = "1.1.0"
  gem.licenses    = ["MIT"]

  gem.authors     = ["Sebastien Rosa"]
  gem.email       = ["sebastien@alchimik.com"]

  gem.files       = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", ['~> 5.0']
  gem.add_development_dependency "sqlite3", "~> 1.3"
  gem.add_development_dependency "rspec-rails", "~> 3.7"
  gem.add_development_dependency "simplecov", "~> 0.15"
  gem.add_development_dependency "simplecov-rcov-text", "~> 0"
end
