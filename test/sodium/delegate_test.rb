require 'test_helper'

class DelegateTest
  include Sodium::Delegate

  def self.[](key)
    sel