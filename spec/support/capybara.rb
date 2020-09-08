# frozen_string_literal: true

require 'webdrivers'

Capybara.register_driver :solidus_chrome_headless do |app|
  Capybara.drivers[:selenium_chrome_headless].call(app).tap do |driver|
    driver.options[:options].args << '--window-size=1920,1080'
  end
end

Capybara.javascript_driver = :solidus_chrome_headless
