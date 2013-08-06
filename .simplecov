# test/test_helper.rb
require 'simplecov'

# features/support/env.rb
require 'simplecov'

# .simplecov
SimpleCov.start 'rails' do
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
end
