require 'test_helper'

describe Sodium::SecretBox::XSalsa20Poly1305 do
  include SodiumTestHelpers

  subject { self.klass.new(self.key) }

  let(:klass)     { Sodium::SecretBox::XSalsa20Poly1305 }
  let(:primitive) { :xsalsa20poly1305 }

  let :constants do
    { :KEYBYTES     => 32,
      :NONCEBYTES 