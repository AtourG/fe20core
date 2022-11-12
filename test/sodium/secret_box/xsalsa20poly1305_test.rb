require 'test_helper'

describe Sodium::SecretBox::XSalsa20Poly1305 do
  include SodiumTestHelpers

  subject { self.klass.new(self.key) }

  let(:klass)     { Sodium::SecretB