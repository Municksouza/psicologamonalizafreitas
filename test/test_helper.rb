# ENV["RAILS_ENV"] ||= "test"
# require_relative "../config/environment"
# require "rails/test_help"
# require "database_cleaner/active_record"
# require "application_system_test_case"
# require "capybara/rails"
# require "capybara/minitest"
# require "selenium/webdriver"
# require "webdrivers"

# # Specify the Chromedriver version you need
# Webdrivers::Chromedriver.required_version = " 128.0.6613.86 "

# class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#   driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
# end

# module ActiveSupport
#   class TestCase
#     # Run tests in parallel with specified workers
#     parallelize(workers: :number_of_processors)

#     # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#     # fixtures :all

#     # Configure DatabaseCleaner
#     DatabaseCleaner.strategy = :truncation

#     setup do
#       DatabaseCleaner.start
#     end

#     teardown do
#       DatabaseCleaner.clean
#     end

#     include Devise::Test::IntegrationHelpers

#     # Add more helper methods to be used by all tests here...
#   end
# end
