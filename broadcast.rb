require 'rubygems'
require 'bundler'
Bundler.require(:broadcast)
require 'capybara/dsl'

Capybara.register_driver :selenium_with_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

session = Capybara::Session.new(:selenium_with_chrome)
session.visit('https://twitter.com')

tweet = "We just released new stuff! Check out what's new at https://snap-ci.com/whats_new"

session.find('#signin-email').set(ENV['TWITTER_USERNAME'])
session.find('#signin-password').set(ENV['TWITTER_PASSWORD'])
session.click_button('Sign in')
session.find('#global-new-tweet-button').click
session.within('#global-tweet-dialog-dialog') do
  session.find('#tweet-box-global').set(tweet)
  session.click_button('Tweet')
end
