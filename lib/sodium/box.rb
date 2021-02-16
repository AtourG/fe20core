require 'sodium'

class Sodium::Box
  include Sodium::Delegate

  def self.keypair
    public_key = Sodium::Buffer.empty self.implementation[:PUBLICKEYBYTES]
    secret_key = Sodium::Buffer.empty self.implementation[:SECRETKEYBYTES]

    self.implementation.nacl_keypair(
      public_key.to_ptr,
      secret_key.to_ptr
    ) or raise Sodium::CryptoError, 'failed to generate a keypair'

    return secret_key, public_key
  end

  def self.afternm(shared_key, message, nonce)
    shared_key = _shared_key(shared_key)
    message    = _message(message)
    nonce      = _nonce(nonce)

    Sodium::Buffer.empty(message.bytesize) do |ciphertext|
      self.implementation.nacl_afternm(
        ciphertext.to_ptr,
        message   .to_ptr,
        message   .bytesize,
        nonce     .to_ptr,
        shared_key.to_ptr
      ) or raise Sodium::CryptoError, 'failed to close the box'
    end.ldrop self.implementation[:BOXZEROBYTES]
  end

  def self.open_afternm(shared_key, ciphertext, nonce)
    shared_key = _shared_key(shared_key)
    ciphertext = _ciphertext(ciphertext)
    nonce      = _nonce(nonce)

    Sodium::Buffer.empty(ciphertext.bytesize) do |message|
      self.implementation.nacl_open_afternm(
        message   .to_ptr,
        ci