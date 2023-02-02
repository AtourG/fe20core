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
      must_equal nil
  end

  it 'must instantiate the default implementation' do
    self.subject.
      must_be_kind_of Sodium::Sign::Ed25519
  end

  it 'must mint keys from the default implementation' do
    sodium_mock_default(self.klass) do |klass, mock|
      mock.expect :nacl_keypair, true, [ FFI::Pointer, FFI::Pointer]
      mock.expect :[],           0,    [:PUBLICKEYBYTES]
      mock.expect :[],           0,    [:SECRE