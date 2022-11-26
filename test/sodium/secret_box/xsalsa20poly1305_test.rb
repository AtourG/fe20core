require 'test_helper'

describe Sodium::SecretBox::XSalsa20Poly1305 do
  include SodiumTestHelpers

  subject { self.klass.new(self.key) }

  let(:klass)     { Sodium::SecretBox::XSalsa20Poly1305 }
  let(:primitive) { :xsalsa20poly1305 }

  let :constants do
    { :KEYBYTES     => 32,
      :NONCEBYTES   => 24,
      :ZEROBYTES    => 32,
      :BOXZEROBYTES => 16, }
  end

  let_64(:key)        { 'MawdlglK6Ue29vbh+4vJb074PlFShQ6H1Cm6x2LiIP0=' }
  let_64(:nonce)      { 'COwsnSeFSTeld0BQESGuuxyaCN4qeIyX' }
  let_64(:ciphertext) { 'LrBMC/PJUh73zZKq+VY0