# # test/application_system_test_case.rb

# require "test_helper"
# # require "selenium/webdriver"

# class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#   # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

#   # Webdrivers::Chromedriver.required_version = " 128.0.6613.86 "

#   # Configure Selenium to use detailed logging
#   Selenium::WebDriver.logger.level = :debug

#   # Set up Chrome options and capabilities
#   options = Selenium::WebDriver::Chrome::Options.new
#   options.add_argument('--headless') # Uncomment if you want to run in headless mode
#   options.add_argument('--disable-gpu')
#   options.add_argument('--no-sandbox')
#   options.add_argument('--disable-dev-shm-usage')

#   # Specify logging preferences
#   options.add_argument('--log-level=3') # 3 is INFO, 2 is WARNING, 1 is SEVERE

#   driven_by :selenium, using: :chrome, options: options
# end
