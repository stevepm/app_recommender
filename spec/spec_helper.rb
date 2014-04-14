ENV['RACK_ENV'] = 'test'
require_relative '../boot'
require_relative '../app'

DB = Sequel.connect(ENV['TEST_DATABASE_URL'])
AppRepository.attach_db(DB)

require 'capybara/rspec'
Capybara.app = App

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
