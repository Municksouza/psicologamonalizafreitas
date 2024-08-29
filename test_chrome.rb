require 'selenium-webdriver'

# Initialize the Chrome driver
driver = Selenium::WebDriver.for :chrome

# Open a website
driver.get 'http://www.google.com'

# Check the title of the page
puts "Title: #{driver.title}"

# Close the browser
driver.quit

