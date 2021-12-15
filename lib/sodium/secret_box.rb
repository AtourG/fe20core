require 'sodium'

class Sodium::SecretBox
  include Sodium::Delegate

  def self.key
    Sodium::Buffer.key self.implementation[:KEYBYTES]
  end

  def initialize(key)
    @key = self.class._key(key)
  end

  def nonce
    Sodium::Buffer.nonce self.implementation[:NONCEBYTES]
  end

  def secret_box(message, nonce)
    message = self.class._message(message)
    nonce   = self.c