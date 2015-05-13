$:.push File.expand_path('../lib', __FILE__)

require 'hyper_admin/version'

Gem::Specification.new do |gem|
  gem.name        = 'hyper_admin'
  gem.version     = HyperAdmin::VERSION
  gem.authors     = ['Sindre Moen']
  gem.email       = ['sindre@hyper.no']
  gem.homepage    = 'http://github.com/hyperoslo/hyper_admin'
  gem.summary     = 'An awesome admin solution for Rails'
  gem.description = 'An awesome admin solution for Rails'
  gem.license     = 'MIT'

  gem.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  gem.test_files = Dir['spec/**/*']

  gem.add_dependency 'coffee-rails', '~> 4.1'
  gem.add_dependency 'jbuilder', '~> 2.2'
  gem.add_dependency 'jquery-rails', '~> 4.0'
  gem.add_dependency 'kaminari', '~> 0.16'
  gem.add_dependency 'rails', '~> 4.2'
  gem.add_dependency 'responders', '~> 2.1'
  gem.add_dependency 'sass-rails', '~> 5.0'

  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_development_dependency 'factory_girl_rails', '~> 4.5'
  gem.add_development_dependency 'faker', '~> 1.4'
  gem.add_development_dependency 'guard-rspec', '~> 4.5'
  gem.add_development_dependency 'pry-rails', '~> 0.3'
  gem.add_development_dependency 'rspec-rails', '~> 3.2'
  gem.add_development_dependency 'sqlite3', '~> 1.3'
  gem.add_development_dependency 'table_print', '~> 1.5'
  gem.add_development_dependency 'whiny_validation', '~> 0.1'
end
