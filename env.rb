require 'rubygems'
require 'bundler/setup'
Bundler.require

Dir['lib/**/*.rb'].each { |f| require_relative f }
