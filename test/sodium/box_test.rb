
require 'test_helper'

describe Sodium::Box do
  include SodiumTestHelpers

  subject       { self.klass.new(*self.keypair) }
  let(:klass)   { Sodium::Box }
  let(:keypair) { self.klass.keypair }

  it 'must default to the Curve22519XSalsa20Poly1305 implementation' do
    self.klass.implementation.
      must_equal Sodium::Box::Curve25519XSalsa20Poly1305
  end

  it 'must allow access to alternate implementations' do
    self.klass.implementation(:xyz).
      must_equal nil
  end

  it 'must instantiate the default implementation' do
    self.subject.
      must_be_kind_of Sodium::Box::Curve25519XSalsa20Poly1305
  end

  it 'must mint keypairs from the default implementation' do
    sodium_mock_default(self.klass) do |klass, mock|
      mock.expect :nacl_keypair, true, [ FFI::Pointer, FFI::Pointer ]