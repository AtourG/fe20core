require 'test_helper'

describe Sodium::OneTimeAuth do
  include SodiumTestHelpers

  subject     { self.klass.new(self.key) }
  let(:klass) { Sodium::OneTimeAuth }
  let(:key)   { self.klass.key }

  it 'must default to the Poly1305 implementation' do
    self.klass.implementation.
      must_equal Sodium::OneTimeAuth::Poly1305
  end

  it 'must allow access to alternate implementations' do
    self.klass.implementation(:foo).
      must_equal nil
  end

  it 'must instantiate the default implementation' do
    self.subject.
      must_be_kind_of Sodium::OneTimeAuth::Poly1305
  end

  it 'must mint keys from the default implementation' do
    sodium_mock_default(self.klass) do |klass, mock|
      mock.expect :[], 0, [:KEYBYTES]

      klass.key.to_s.must_equal ''
    end
  end

  it 'must raise when instantiating with an invalid key