require 'test_helper'

describe Sodium::OneTimeAuth do
  include SodiumTestHelpers

  subject     { self.klass.new(self.key) }
  let(:k