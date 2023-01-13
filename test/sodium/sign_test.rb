require 'test_helper'

describe Sodium::Sign do
  include SodiumTestHelpers

  subject       { self.klass.new(self.keypair.first) }
  let(:klass)   { Sodium::Sign }
  let(:keypair) { self.klass.keypair }

  it 'must default to the Ed2551