require 'coveralls'
require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
  add_filter '/vendor/'
end

Coveralls.wear! if 