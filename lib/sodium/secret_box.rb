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
    nonce   = self.class._nonce(nonce)

    Sodium::Buffer.empty(message.bytesize) do |ciphertext|
      self.implementation.nacl(
        ciphertext .to_ptr,
        message    .to_ptr,
        message    .bytesize,
        nonce      .to_ptr,
        @key       .to_ptr
      ) or raise Sodium::CryptoError, 'failed to close the secret box'
    end.ldrop self.implementation[:BOXZEROBYTES]
  end

  def open(ciphertext, nonce)
    ciphertext = self.class._ciphertext(ciphertext)
    nonce      = self.class._nonce(nonce)

    Sodium::Buffer.empty(ciphertext.bytesize) do |message|