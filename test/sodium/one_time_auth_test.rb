require 'test_helper'

describe Sodium::OneTimeAuth do
  include SodiumTestHelpers

  subject     { self.klass.new(self.key) }
  let(:klass) { Sodium::OneTimeAuth }
  let(:key)   { self.klass.key }

  it 'must default to the Poly1305 implementation' do
    self.klass.implementation.
      must_equal Sodi