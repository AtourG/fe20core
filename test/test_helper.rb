require 'coveralls'
require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
  add_filter '/vendor/'
end

Coveralls.wear! if ENV['TRAVIS']

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

require 'sodium'
require 'base64'

module SodiumTestHelpers
  module ClassMethods
    def let_64