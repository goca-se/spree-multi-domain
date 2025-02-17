# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_multi_domain'
  s.version     = '3.1.0'
  s.summary     = 'Adds multiple site support to Spree'
  s.description = 'Multiple Spree stores on different domains - single unified backed for processing orders.'
  s.required_ruby_version = '>= 2.1.0'

  s.authors           = ['Brian Quinn', 'Roman Smirnov', 'David North']
  s.email             = 'brian@railsdog.com'
  s.homepage          = 'http://spreecommerce.com'
  s.rubyforge_project = 'spree_multi_domain'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  version = '3.1.14.rails.5.0.1'
  s.add_dependency 'goca-spree-core', version
  s.add_dependency 'goca-spree-backend', version
  s.add_dependency 'goca-spree-frontend', version
  s.add_dependency 'goca-spree-api', version

  s.add_development_dependency 'capybara', '~> 2.15.0'
  s.add_development_dependency 'coffee-rails', '~> 4.1.1'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker', '~> 2.2.0'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails',  '~> 3.5.2'
  s.add_development_dependency 'sass-rails', '~> 5.0.0'
  s.add_development_dependency 'sqlite3', '~> 1.3.13'
end
