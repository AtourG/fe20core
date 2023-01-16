require 'test_helper'

describe Sodium::Sign do
  include SodiumTestHelpers

  subject       { self.klass.new(self.keypair.first) }
  let(:klass)   { Sodium::Sign }
  let(:keypair) { self.klass.keypair }

  it 'must default to the Ed25519 implementation' do
    self.klass.implementation.
      must_equal Sodium::Sign::Ed25519
  end

  it 'must allow access to alternate implementations' do
    self.klass.implementation(:xyz).
      must_eq