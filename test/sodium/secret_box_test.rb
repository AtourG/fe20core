
require 'test_helper'

describe Sodium::SecretBox do
  include SodiumTestHelpers

  subject     { self.klass.new(self.key) }
  let(:klass) { Sodium::SecretBox }
  let(:key)   { self.klass.key }

  it 'must default to the XSalsa20Poly1305 implementation' do
    self.klass.implementation.