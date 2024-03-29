
require 'test_helper'

describe Sodium::Auth do
  include SodiumTestHelpers

  subject     { self.klass.new(self.key) }
  let(:klass) { Sodium::Auth             }
  let(:key)   { self.klass.key           }

  it 'must default to the HMACSHA512256 implementation' do
    self.klass.implementation.
      must_equal Sodium::Auth::HMACSHA512256
  end

  it 'must allow access to alternate implementations' do
    self.klass.implementation(:hmacsha256).
      must_equal Sodium::Auth::HMACSHA256
  end

  it 'must instantiate the default implementation' do
    self.subject.
      must_be_kind_of Sodium::Auth::HMACSHA512256
  end

  it 'must mint keys from the default implementation' do
    sodium_mock_default(self.klass) do |klass, mock|
      mock.expect :[], 0, [:KEYBYTES]

      klass.key.to_s.must_equal ''
    end
  end

  it 'must raise when instantiating with an invalid key' do
    lambda { self.klass.new(self.key.to_s[0..-2]) }.
      must_raise Sodium::LengthError
  end

  it 'must raise when verifying an invalid authenticator' do
    lambda { self.subject.verify('message', 'blaaah') }.
      must_raise Sodium::LengthError
  end

  it 'must raise when failing to generate an authenticator' do
    sodium_stub_failure(self.klass, :nacl) do
      lambda { self.subject.auth('message') }.
        must_raise Sodium::CryptoError
    end
  end
end