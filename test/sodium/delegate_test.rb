require 'test_helper'

class DelegateTest
  include Sodium::Delegate

  def self.[](key)
    self.const_get(key)
  end

  class Subclass1 < self; PRIMITIVE = :subclass1; end
  class Subclass2 < self; PRIMITIVE = :subc