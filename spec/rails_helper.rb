ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'factory_girl_rails'

require 'coveralls'
Coveralls.wear!

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
end
