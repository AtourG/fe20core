require 'sodium'

class Sodium::Auth
  include Sodium::Delegate

  def self.key
    Sodium::Buffer.key self.implementation[:KEYBYTES]
  end

  def self.auth(key, message)
    key     = self._key(key)
    message = self._message(message)

    Sodium::Buffer.empty self.implementation[:BYTES] do |authenticator|
      self.implementation.nacl(
        authenticator.to_ptr,
        message      .to_ptr,
        message      .bytesize,
        key          .to_ptr
      ) or raise Sodium::CryptoError, 'failed to generate an authenticator'
    end
  end

  def self.verify(key, message, authenticator)
    key           = self._key(key)
    message       = self._message(message)
    authenticator = self._authenticator(authenticator)

    self.implementation.nacl_verify(
      authenticator.to_ptr,