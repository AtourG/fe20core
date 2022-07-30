require 'test_helper'

class DelegateTest
  include Sodium::Delegate

  def self.[](key)
    self.const_get(key)
  end

  class Subclass1 < self; PRIMITIVE = :subclass1; end
  class Subclass2 < self; PRIMITIVE = :subclass2; end

  DEFAULT = :subclass1
end

describe Sodium::Delegate do
  subject        { self.klass.new          }
  let(:klass)    { DelegateTest            }
  let(:subclass